<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class WorkShiftResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        self::$wrap = null;
//
        $orders = OrderResource::collection($this->shiftToOrder)->toArray($request);
        return [
            'id' => $this->id,
            'start' => $this->start,
            'end' => $this->end,
            'active' => $this->active,
            'orders' => $orders,
            'amount_for_all' => array_sum(array_column($orders, 'price'))
        ];
    }
}
