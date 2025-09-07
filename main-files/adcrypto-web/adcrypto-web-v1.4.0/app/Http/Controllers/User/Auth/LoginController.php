<?php

namespace App\Http\Controllers\User\Auth;

use Exception;
use Illuminate\Http\Request;
use App\Traits\User\LoggedInUsers;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use App\Providers\Admin\BasicSettingsProvider;
use Illuminate\Validation\ValidationException;
use Illuminate\Foundation\Auth\AuthenticatesUsers;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    protected $request_data;

    use AuthenticatesUsers,LoggedInUsers;

    public function showLoginForm() {
        $page_title           = "- User Login";
        $basic_settings       = BasicSettingsProvider::get();
        
        return view('user.auth.login',compact(
            'page_title',
            'basic_settings'
            
        ));
    }


    /**
     * Validate the user login request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return void
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    protected function validateLogin(Request $request)
    {
        $this->request_data = $request;
        $request->validate([
            'credentials'   => 'required|string',
            'password'      => 'required|string',
        ]);
    }


    /**
     * Get the needed authorization credentials from the request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    protected function credentials(Request $request)
    {
        $request->merge(['status' => true]);
        $request->merge([$this->username() => $request->credentials]);
        return $request->only($this->username(), 'password','status');
    }


    /**
     * Get the login username to be used by the controller.
     *
     * @return string
     */
    public function username()
    {
        $request = $this->request_data->all();
        $credentials = $request['credentials'];
        if(filter_var($credentials,FILTER_VALIDATE_EMAIL)) {
            return "email";
        }
        return "username";
    }

    /**
     * Get the failed login response instance.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Symfony\Component\HttpFoundation\Response
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    protected function sendFailedLoginResponse(Request $request)
    {
        throw ValidationException::withMessages([
            "credentials" => [trans('auth.failed')],
        ]);
    }


    /**
     * Get the guard to be used during authentication.
     *
     * @return \Illuminate\Contracts\Auth\StatefulGuard
     */
    protected function guard()
    {
        return Auth::guard("web");
    }


    /**
     * The user has been authenticated.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  mixed  $user
     * @return mixed
     */
    protected function authenticated(Request $request, $user)
    {
        // Check if email verification is required and user is not verified
        $basic_settings = BasicSettingsProvider::get();
        if ($basic_settings->email_verification == true && $user->email_verified != 1) {
            if ($request->has('verification_code')) {
                $verification_code = $request->verification_code;
                $verification_data = \App\Models\UserAuthorization::where('user_id', $user->id)->where('code', $verification_code)->first();
                if ($verification_data) {
                    $user->email_verified = 1;
                    $user->save();
                    $verification_data->delete();
                } else {
                    Auth::logout();
                    return redirect()->route('user.login')->with(['error' => ['Invalid verification code.']]);
                }
            } else {
                // Log the user out
                Auth::logout();
                
                // Generate new verification code and send email
                try {
                    // Generate verification data
                    $data = [
                        'user_id'       => $user->id,
                        'code'          => generate_random_code(),
                        'token'         => generate_unique_string("user_authorizations","token",200),
                        'created_at'    => now(),
                    ];

                    // Store in database and send email
                    \DB::beginTransaction();
                    try{
                        \App\Models\UserAuthorization::where("user_id",$user->id)->delete();
                        \DB::table("user_authorizations")->insert($data);
                        $user->notify(new \App\Notifications\User\Auth\SendAuthorizationCode((object) $data));
                        \DB::commit();
                        
                        // Redirect to login page with message
                        return redirect()->route('user.login')->with(['warning' => ['Please verify your email address. A verification code has been sent to your email inbox. Please check your email and enter the code on the login page.'], 'unverified_email' => true]);
                    }catch(\Exception $e) {
                        \DB::rollBack();
                        // Fall back to login message
                        return redirect()->route('user.login')->with(['error' => ['Please verify your email address. A verification code has been sent to your email inbox. Please check your email and enter the code when logging in.'], 'unverified_email' => true]);
                    }
                } catch (\Exception $e) {
                    // If there's an error with mail verification, fall back to login message
                    return redirect()->route('user.login')->with(['error' => ['Please verify your email address. A verification code has been sent to your email inbox. Please check your email and enter the code when logging in.'], 'unverified_email' => true]);
                }
            }
        }
        
        $user->two_factor_verified = 0;
        $user->save();
        $this->refreshUserWallets($user);
        $this->createLoginLog($user);

        if ($request->has('verification_code')) {
            return redirect()->route('user.dashboard')->with(['success' => ['Account successfully verified']]);
        }

        return redirect()->intended(route('user.dashboard'));
    }
}
