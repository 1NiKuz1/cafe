<?php

namespace App\Http\Controllers;
use App\Http\Requests\UserAddRequest;
use App\Http\Resources\UserResource;
use App\Models\User;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;
use App\Exceptions\ApiException;
use App\Http\Requests\UserLoginRequest;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    public function index() {
        return UserResource::collection(User::all());
    }
    public function show() {
        $user = Auth::user();
        return response()->json([
            'data' => [
                'id' => $user->id,
                'name' => $user->name,
                'role' => $user->role->name,
            ]
        ])->setStatusCode(200);
    }

    public function store(UserAddRequest $userRequest)
    {
        $user = User::create([
            'photo_file' => $userRequest->photo_file ? $userRequest->photo_file->store('photos') : null, ] + $userRequest->all()
        );
        return response()->json([
            'data' => [
                'id' => $user->id,
                'status' => 'created'
            ]
        ])->setStatusCode(201, 'Created');
    }

    public function update(Request $request, User $user)
    {
        return "update user ${request} ${user}";
    }

    public function destroy(User $user)
    {
        return "dellete user ${user}";
    }

    public function login(UserLoginRequest $request)
    {
        $user = User::where([
            'login' => $request->login,
            'password' => $request->password,
        ])->first();
        if (!$user) {
            throw new ApiException(401, 'Authebtication failed');
        }

        return response()->json([
            'data' => [
                'user_token' => $user->generateToken(),
                'id' => $user->id,
                'name' => $user->name,
                'role' => $user->role->name,
            ]
        ]);
    }

    public function logout()
    {
        Auth::user()->logout();
        return [
            'data' => [
                'message' => 'logout'
            ]
        ];
    }
}
