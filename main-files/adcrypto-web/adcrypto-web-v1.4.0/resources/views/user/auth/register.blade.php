@php
    $app_local      = get_default_language_code();
    $slug           = Illuminate\Support\Str::slug(App\Constants\SiteSectionConst::REGISTER_SECTION);
    $register       = App\Models\Admin\SiteSections::getData($slug)->first();
@endphp
@extends('layouts.master')

@push('css')
    <style>
        .account-form-area {
            background: rgba(10, 12, 35, 0.7);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 30px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .form--control {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.15);
            color: #fff;
            border-radius: 8px;
        }
        
        .form--control:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(1, 148, 252, 0.5);
            box-shadow: 0 0 0 3px rgba(1, 148, 252, 0.2);
        }
        
        .form--control::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }
        
        .btn-google {
            position: relative;
            overflow: hidden;
            font-weight: 600;
            background: rgba(255, 255, 255, 0.15);
            color: #ffffff;
            padding: 13px 40px;
            border-radius: 30px;
            text-align: center;
            z-index: 2;
            -webkit-transition: all 0.5s;
            transition: all 0.5s;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            text-decoration: none;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
        }
        
        .btn-google::before {
            position: absolute;
            content: "";
            top: 0;
            right: 0;
            width: 0;
            height: 100%;
            background: #ffffff;
            z-index: -1;
            -webkit-transition: all 0.5s;
            transition: all 0.5s;
        }
        
        .btn-google:focus, .btn-google:hover {
            color: #757575;
        }
        
        .btn-google:focus::before, .btn-google:hover::before {
            right: auto;
            left: 0;
            width: 100%;
        }
        
        .btn-google i {
            margin-right: 10px;
            font-size: 18px;
            color: #DB4437;
            z-index: 3;
        }
        
        .btn-google:focus i, .btn-google:hover i {
            color: #DB4437;
        }
        
        .or-section {
            position: relative;
            text-align: center;
            margin: 20px 0;
        }
        
        .or-section span {
            background-color: #090B2C;
            position: relative;
            padding: 0 15px;
            z-index: 1;
            color: #c4c6c7;
        }
        
        .or-section:before {
            content: "";
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background-color: rgba(255, 255, 255, 0.2);
            z-index: 0;
        }
        
        .account-item label, .terms-item label {
            color: rgba(255, 255, 255, 0.8);
        }
        
        .account-control-btn {
            color: #0194FC;
            font-weight: 500;
        }
        
        .account-control-btn:hover {
            color: #0178d4;
            text-decoration: underline;
        }
        
        a {
            color: #0194FC;
        }
        
        a:hover {
            color: #0178d4;
            text-decoration: underline;
        }
        
        .custom-check-group label {
            color: rgba(255, 255, 255, 0.8);
        }
    </style>
@endpush

@section('content')
<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Start Account
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
<div class="account-section">
    <div class="account-inner">
        <div class="account-area change-form" style="background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(10px); -webkit-backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 15px;">
            <div class="account-thumb">
                <img src="{{ get_image($register->value->image , 'site-section') }}" alt="element">
            </div>
            <div class="account-form-area">
                <div class="account-logo">
                    <a class="site-logo site-title" href="{{ setRoute('index') }}"><img src="{{ get_logo($basic_settings) }}" alt="site-logo"></a>
                </div>
                <h4 class="title">{{ @$register->value->language->$app_local->title ?? '' }}</h4>
                <p>{{ @$register->value->language->$app_local->heading ?? '' }}</p>
                <form action="{{ setRoute('user.register.submit') }}" class="account-form" method="POST" autocomplete="on">
                    @csrf
                    <div class="row">
                        <div class="col-lg-6 col-md-12 form-group">
                            <input type="text" class="form-control form--control" name="firstname" value="{{ old('firstname') }}" placeholder="{{ __("First Name") }}" required>
                        </div>
                        <div class="col-lg-6 col-md-12 form-group">
                            <input type="text" class="form-control form--control" name="lastname" value="{{ old('lastname') }}" placeholder="{{ __("Last Name") }}" required>
                        </div>
                        <div class="col-lg-12 form-group">
                            <input type="email" class="form-control form--control" name="email" value="{{ old('email') }}" placeholder="{{ __("Email") }}" required>
                        </div>
                        <div class="col-lg-12 form-group show_hide_password">
                            <input type="password" class="form-control form--control" name="password" value="{{ old('password') }}" placeholder="{{ __("Password") }}" required>
                            <span class="show-pass"><i class="fa fa-eye-slash" aria-hidden="true"></i></span>
                        </div>
                        <div class="col-lg-12 form-group">
                            <div class="custom-check-group">
                                <input type="checkbox" name="agree" id="level-1">
                                @php
                                    $data = App\Models\Admin\UsefulLink::where('type',global_const()::USEFUL_LINK_PRIVACY_POLICY)->first();
                                @endphp
                                <label for="level-1">{{ __("I have agreed with") }} <a class="text--base" href="{{ setRoute('link',$data->slug) }}" target="_blank">{{ __("Terms Of Use & Privacy Policy") }}</a></label>
                            </div>
                        </div>
                        <div class="col-lg-12 form-group text-center">
                            <button type="submit" class="btn--base w-100"><span class="w-100">{{ __("Register Now") }}</span></button>
                        </div>
                        
                        <!-- Google Register Button -->
                        <div class="col-lg-12 form-group text-center">
                            <div class="or-section">
                                <span>{{ __("OR") }}</span>
                            </div>
                            <a href="{{ route('user.social.auth.google') }}" class="btn-google w-100">
                                <i class="fab fa-google"></i> {{ __("Sign up with Google") }}
                            </a>
                        </div>
                        
                        <div class="col-lg-12 text-center">
                            <div class="account-item">
                                <label>{{ __("Already Have An Account?") }} <a href="{{ setRoute('user.login') }}" class="account-control-btn">{{ __("Login Now") }}</a></label>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    End Account
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
@endsection

@push('script')
<script>
    function deRequireCb(elClass) {
  el = document.getElementsByClassName(elClass);

  var atLeastOneChecked = false; //at least one cb is checked
  for (i = 0; i < el.length; i++) {
    if (el[i].checked === true) {
      atLeastOneChecked = true;
    }
  }

  if (atLeastOneChecked === true) {
    for (i = 0; i < el.length; i++) {
      el[i].required = false;
    }
  } else {
    for (i = 0; i < el.length; i++) {
      el[i].required = true;
    }
  }
}
</script>
@endpush