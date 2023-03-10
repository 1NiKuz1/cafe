<?php

namespace App\Http\Middleware;

use Illuminate\Auth\Middleware\Authenticate as Middleware;
use Illuminate\Http\Exceptions\HttpResponseException;
use App\Exceptions\ApiException;

class Authenticate extends Middleware
{
    /**
     * Get the path the user should be redirected to when they are not authenticated.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return string|null
     */
    
    protected function unauthenticated($request, array $guards)
    {
        // $response = response()->json([
        //     'error' => [
        //         'code' => 403,
        //         'message' => 'Login failed'
        //     ]
        // ], 403);
        throw new ApiException(403, 'Login failed');
    }
}
