<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\WorkShiftController;
use App\Http\Controllers\OrderController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::get('/logout', [UserController::class, "logout"]);
Route::post('/login', [UserController::class, "login"])->withoutMiddleware(['auth:api']);

Route::middleware('role:admin')->group(function() {
    Route::prefix('user')->group(function() {
        Route::get('/', [UserController::class, "index"]);
        Route::post('/', [UserController::class, "store"]);
    });
});

Route::prefix('work-shift')->group(function() {
    Route::middleware('role:admin')->group(function() {
        Route::post('/', [WorkShiftController::class, "store"]);
        Route::get('/{workShift}/open', [WorkShiftController::class, "openWorkShift"]);
        Route::get('/{workShift}/close', [WorkShiftController::class, "closeWorkShift"]);
        Route::post('/{workShift}/user', [WorkShiftController::class, "addUser"]);
    });
    Route::middleware('role:admin|waiter')->group(function() {
        Route::get('/{workShift}/order', [WorkShiftController::class, "show"]);
        Route::get('/', [WorkShiftController::class, "showAll"]);
    });
});

Route::prefix('order')->group(function() {
    Route::middleware('role:cook')->group(function() {
        Route::get('/taken', [OrderController::class, "currentOrders"]);
    });
    Route::middleware('role:waiter')->group(function() {
        Route::post('/', [OrderController::class, "store"]);
        Route::get('/{order}', [OrderController::class, "show"]);
        Route::post('/{orderId}/position', [OrderController::class, "addPosition"]);
        Route::delete('/{orderId}/position/{position}', [OrderController::class, "delPosition"]);
    });
    Route::middleware('role:waiter|cook')->group(function() {
        Route::patch('/{orderId}/change-status', [OrderController::class, "update"]);
    });
});
