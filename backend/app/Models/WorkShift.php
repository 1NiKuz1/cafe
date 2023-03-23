<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WorkShift extends Model
{
    use HasFactory;

    protected $fillable = [
        'id', 'start', 'end', 'active'
    ];

    public function UserShiftWorker()
    {
       return $this->belongsToMany(User::class, 'shift_workers');
    }

    public function shiftToOrder()
    {
       return $this->hasManyThrough(Order::class, ShiftWorker::class);
    }

}
