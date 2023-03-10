<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class OrderResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'table' => $this->table->name,
            'shift_workers' => $this->OrderToUser->name,
            'create_at' => $this->create_at,
            'status' => $this->OrderToStatus->name,
            'price' => array_reduce(PositionResource::collection($this->OrderToMenu)->toArray($request), function ($sum, $cur) {
                return $sum + $cur['price'] * $cur['count'];
            })
        ];
    }
}
