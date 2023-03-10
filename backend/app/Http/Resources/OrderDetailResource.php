<?php

namespace App\Http\Resources;

use App\Models\ShiftWorker;
use App\Models\Table;
use App\Models\User;
use Illuminate\Http\Resources\Json\JsonResource;

class OrderDetailResource extends JsonResource
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
            'positions' => PositionResource::collection($this->OrderToMenu),
            'price_all' => array_sum(array_column(PositionResource::collection($this->OrderToMenu)->toArray($request), 'price'))
        ];
    }

}
