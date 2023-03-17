<?php

namespace App\Http\Controllers;

use App\Exceptions\ApiException;
use App\Http\Requests\CloseRequest;
use App\Http\Requests\OpenRequest;
use App\Http\Requests\WorkShiftRequest;
use App\Http\Resources\WorkShiftResource;
use App\Models\ShiftWorker;
use App\Models\WorkShift;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class WorkShiftController extends Controller
{

    public function index()
    {
        return "all workShifts";
    }

    public function store(WorkShiftRequest $workShiftRequest)
    {
        $workShift = WorkShift::create($workShiftRequest->all());
        return response()->json([
            'data' => [
                'id' => $workShift->id,
                'status' => 'created'
            ]
        ])->setStatusCode(201, 'Created');
    }


    public function show($workShift)
    {
        $shift = WorkShift::where(['id' => $workShift])->first();
        if (!$shift)
            throw new ApiException(403, 'The shift was not found');
        return WorkShiftResource::collection([$shift]);
    }


    public function update(Request $request, WorkShift $workShift)
    {
        return "update workShifts ${request} ${workShift}";
    }

    public function destroy(WorkShift $workShift)
    {
        return "dellete workShifts ${workShift}";
    }

    public function openWorkShift(OpenRequest $openRequest, $workShift) {
        if (WorkShift::where(['active' => 1])->first())
            throw new ApiException(403, 'Forbidden. There are open shifts');
        $shift = WorkShift::where(['id' => $workShift])->first();
        if (!$shift)
            throw new ApiException(403, 'The shift was not found');
        $shift->active = 1;
        $shift->save();
        return response()->json([
            'data' => [
                'id' => $shift->id,
                'start' => $shift->start,
                'end' => $shift->end,
                'active' => $shift->active,
            ]
        ])->setStatusCode(201, 'Changed');
    }

    public function closeWorkShift(CloseRequest $closeRequest, $workShift) {
        $shift = WorkShift::where(['id' => $workShift])->first();
        if (!$shift)
            throw new ApiException(403, 'The shift was not found');
        if ($shift->active == 0)
            throw new ApiException(403, 'Forbidden. The shift is already closed!');
        $shift->active = 0;
        $shift->save();
        return response()->json([
            'data' => [
                'id' => $shift->id,
                'start' => $shift->start,
                'end' => $shift->end,
                'active' => $shift->active,
            ]
        ])->setStatusCode(201, 'Changed');
    }

    public function addUser(Request $request, $workShift) {

        $userId = $request->user_id;

        $shiftWorker = ShiftWorker::firstWhere([
            'user_id' => $userId,
            'work_shift_id' => $workShift
        ]);

        if ($shiftWorker != null) {
            throw new ApiException(403, "Forbidden. The worker is already on shift!");
        }

        ShiftWorker::create([
            'work_shift_id' => $workShift,
            'user_id' => $userId
        ]);

        return response()->json([
            'data' => [
                'id_user' => $userId,
                'stats' => "added"
            ]
        ])->setStatusCode(201, 'Added');
    }

    public function showAll() {
        $workShifts = WorkShift::all();
        return WorkShiftAllResource::collection($workShifts);
    }
}
