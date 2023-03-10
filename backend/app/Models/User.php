<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Str;

class User extends Authenticatable
{
    use HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'login', 'api_token', 'password', 'role_id', 'photo_file'
    ];

    //protected $guarded = [];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function generateToken() {
        $this->update([
            'api_token' => Str::random(25)
        ]);
        return $this->api_token;
    }

    public function logout()
    {
        $this->update([
            'api_token' => null
        ]);
    }

    public function role()
    {
       return $this->belongsTo(Role::class);
    }

    public function swiftWorker()
    {
       return $this->hasMany(ShiftWorker::class);
    }

    public function hasRole($roles)
    {
       return in_array($this->role->code, $roles);
    }
}
