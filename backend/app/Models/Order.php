<?php

namespace App\Models;

use App\Http\Resources\PositionResource;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;

    protected $fillable = [
        'shift_worker_id', 'work_shift_id', 'table_id', 'number_of_person', 'status_order_id'
    ];

    public function table()
    {
        return $this->belongsTo(Table::class);
    }

    public function OrderToStatus()
    {
        return $this->belongsTo(StatusOrder::class, 'status_order_id');
    }

    public function OrderToUser()
    {
        return $this->hasOneThrough(
            User::class,
            ShiftWorker::class,
            'id',
            'id',
            'shift_worker_id',
            'user_id'
        );
    }

//    public function SumOfPrices()
//    {
//        $positions = PositionResource::collection($this->OrderToMenu);
//        $priceAll = 0;
//        foreach ($positions as $pos) {
//            $priceAll = $priceAll + $pos->price;
//        }
//        return $priceAll;
//    }

    public function OrderToMenu()
    {
        return $this->hasMany(OrderMenu::class);
    }

    public function OrderToShift()
    {
        return $this->hasOneThrough(
            WorkShift::class,
            ShiftWorker::class,
            'id',
            'id',
            'shift_worker_id',
            'work_shift_id'
        );
    }
}
