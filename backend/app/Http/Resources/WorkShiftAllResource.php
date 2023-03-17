<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class WorkShiftAllResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        self::$wrap = null;
        return [
            'id' => $this->id,
            'start' => $this->start,
            'end' => $this->end,
            'active' => $this->active,
        ];
        //return parent::toArray($request);
    }
}
