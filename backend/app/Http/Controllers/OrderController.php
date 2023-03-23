<?php

namespace App\Http\Controllers;

use App\Exceptions\ApiException;
use App\Http\Requests\AddPositionRequest;
use App\Http\Requests\AddRequest;
use App\Http\Requests\RemovePositionRequest;
use App\Http\Requests\ShowRequest;
use App\Http\Resources\OrderDetailResource;
use App\Http\Resources\OrderResource;
use App\Models\Order;
use App\Models\OrderMenu;
use App\Models\User;
use App\Models\WorkShift;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Ramsey\Uuid\Type\Integer;

class OrderController extends Controller
{

    public function index()
    {
        return "all orders";
    }

    public function store(AddRequest $addRequest)
    {
        $workShift = WorkShift::where(['active' => 1])->first();
        if ($workShift == null) {
            throw new ApiException(403, "Forbidden. The shift must be active!");
        }

        $throw = true;
        $user = User::where(['api_token' => $addRequest->bearerToken()])->first();
        $shifts = $user->swiftWorker;
        $needShift;
        foreach ($shifts as $shift) {
            if ($shift->work_shift_id == $addRequest->work_shift_id) {
                $throw = false;
                $needShift = $shift;
            }
        }

        if ($throw) {
            throw new ApiException(403, "Forbidden. You don't work this shift!");
        }
        return OrderResource::make(Order::create([
            'number_of_person' => $addRequest->number_of_person,
            'table_id' => $addRequest->table_id,
            'shift_worker_id' => $needShift->id,
            'status_order_id' => 1
        ]));
    }

    public function show(ShowRequest $showRequest, $order)
    {
        $userId = User::where(['api_token' => $showRequest->bearerToken()])->first()->id;
        $shiftWorkerId = Order::find($order)->OrderToUser->id;
        if ($userId != $shiftWorkerId) {
            throw new ApiException(403, "Forbidden. You did not accept this order!");
        }
        return OrderDetailResource::collection([Order::where(['id' => $order])->first()]);
    }

    public function update(Request $request, $orderId)
    {
        $order = Order::find($orderId);
        $user = User::where(['api_token' => $request->bearerToken()])->first();
        $statusRequest = $request->status;
        $statusRequestId = -1;
        switch ($statusRequest) {
            case "taken":
                $statusRequestId = 1;
                break;
            case "preparing":
                $statusRequestId = 2;
                break;
            case "ready":
                $statusRequestId = 3;
                break;
            case "paid-up":
                $statusRequestId = 4;
                break;
            case "canceled":
                $statusRequestId = 5;
                break;
        }

        $throw = false;
        $orderStatus = $order->OrderToStatus->code;
        $userRoleId = $user->role->id;
        switch ($userRoleId) {
            case 2:
                if (!($orderStatus == "taken" && $statusRequest == "canceled" || $orderStatus == "ready" && $statusRequest == "paid-up"))
                    $throw = true;
                break;
            case 3:
                if (!($orderStatus == "taken" && $statusRequest == "preparing" || $orderStatus == "preparing" && $statusRequest == "ready"))
                    $throw = true;
                break;
        }

        if ($throw) {
            throw new ApiException(403, "Forbidden! Can't change existing order status");
        }

        $userId = $user->id;
        $shiftWorkerId = $order->OrderToUser->id;
        if ($userId != $shiftWorkerId && $userRoleId != 3) {
            throw new ApiException(403, "Forbidden. You did not accept this order!");
        }

        if (!$order->OrderToShift->active) {
            throw new ApiException(403, "Forbidden. You cannot change the order status of a closed shift");
        }

        $order->update([
            'status_order_id' => $statusRequestId
        ]);

        return response()->json([
            'data' => [
                'id' => $orderId,
                'status' => $statusRequest
            ]
        ]);
    }


    public function destroy(RemovePositionRequest $removePositionRequest)
    {
        return $removePositionRequest;
    }

    public function addPosition(AddPositionRequest $addPositionRequest, $orderId) {
        $user = Auth::user();
        $order = Order::find($orderId);

        if ($user->id != $order->OrderToUser->id) {
            throw new ApiException(403, "Forbidden. You did not accept this order!");
        }

        if (!$order->OrderToShift->active) {
            throw new ApiException(403, "Forbidden! You cannot change the order status of a closed shift");
        }

        if (!($order->OrderToStatus->id == 1 || $order->OrderToStatus->id == 2)) {
            throw new ApiException(403, "Forbidden! Cannot be added to an order with this status!");
        }

        OrderMenu::create([
            'menu_id' => $addPositionRequest->menu_id,
            'order_id' => $orderId,
            'count' => $addPositionRequest->count,
        ]);

        return OrderDetailResource::make($order);
    }

    public function delPosition(RemovePositionRequest $removePositionRequest, $orderId, $position) {
        $user = Auth::user();
        $order = Order::find($orderId);

        if ($user->id != $order->OrderToUser->id) {
            throw new ApiException(403, "Forbidden. You did not accept this order!");
        }

        if (!$order->OrderToShift->active) {
            throw new ApiException(403, "Forbidden! You cannot change the order status of a closed shift");
        }

        if ($order->OrderToStatus->id != 1) {
            throw new ApiException(403, "Forbidden! Cannot be added to an order with this status!");
        }

        OrderMenu::destroy($position);
        return OrderDetailResource::make($order);
    }

    public function currentOrders() {
        $orders = Order::all();
        $newOrders = [];
        foreach ($orders as $order) {
            if (!$order->OrderToShift->active) continue;
            if (!($order->status_order_id == 1 || $order->status_order_id == 2)) continue;

            array_push($newOrders, $order);
        }

        return OrderResource::collection($newOrders);
    }
}
