<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Tymon\JWTAuth\Facades\JWTAuth;
use Tymon\JWTAuth\Token;

class TokenValidationTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
    }

    public function test_token_is_valid()
    {
        $user = User::factory()->create();

        // Generate a token for the user
        $token = JWTAuth::fromUser($user);

        // Make the request with the generated token
        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->getJson('/api/me');

        $response->assertStatus(200)
                 ->assertJson(['id' => $user->id, 'email' => $user->email]);
    }

    public function test_token_is_invalid()
    {
        $response = $this->withHeaders([
            'Authorization' => 'Bearer invalidtoken',
        ])->getJson('/api/me');

        $response->assertStatus(401)
                 ->assertJson(['error' => 'Unauthenticated.']);
    }
}
