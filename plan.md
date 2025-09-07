# Google Sign-In Integration Plan

This document outlines the steps to add a "Sign in with Google" button to the login and registration pages.

## 1. Add Google Sign-In Button to Login Page

I'll insert the following code into `main-files/adcrypto-web/adcrypto-web-v1.4.0/resources/views/user/auth/login.blade.php` after the login button (around line 45):

```html
<div class="col-lg-12 text-center">
    <div class="or-area">
        <hr>
        <p>Or</p>
        <hr>
    </div>
</div>
<div class="col-lg-12 form-group">
    <div class="account-form-btn">
        <a href="{{ setRoute('user.social.auth.google') }}" class="btn--base w-100 btn-google"><i class="fab fa-google"></i> {{ __("Sign In with Google") }}</a>
    </div>
</div>
```

## 2. Add Google Sign-In Button to Registration Page

I'll add a similar button to the registration page, located at `main-files/adcrypto-web/adcrypto-web-v1.4.0/resources/views/user/auth/register.blade.php`.

## 3. Verify Google API Credentials

I'll need to ensure that the Google API credentials are included in the `.env` file and referenced in `config/services.php`.

## 4. Test the Implementation

Once the buttons are in place and the credentials have been verified, I'll test the Google sign-in functionality to ensure it's working correctly.