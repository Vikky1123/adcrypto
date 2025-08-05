<?php

namespace Database\Seeders\Admin;

use Illuminate\Database\Seeder;
use App\Models\Admin\BasicSettings;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class FreshBasicSettingsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data = [
            'site_name'         => "AdCrypto",
            'site_title'        => "Coin Buy & Sale Cryptocurrency Platform",
            'base_color'        => "#0194FC",
            'secondary_color'   => "#0194FC",
            'otp_exp_seconds'   => "3600",
            'timezone'          => "Asia/Dhaka",
            'user_registration' => 1,
            'agree_policy'      => 1,
            'broadcast_config'  => [
                "method"        => "", 
                "app_id"        => "", 
                "primary_key"   => "", 
                "secret_key"    => "", 
                "cluster"       => "" 
            ],
            'push_notification_config'  => [
                "method"                => "", 
                "instance_id"           => "", 
                "primary_key"           => ""
            ],
            'email_verification'    => true,
            'email_notification'    => true,
            'kyc_verification'      => true,
            'site_logo_dark'        => 'seeder/logo-dark.webp',
            'site_logo'             => 'seeder/logo-white.webp',
            'site_fav_dark'         => 'seeder/fav-icon.webp',
            'site_fav'              => 'seeder/fav-icon.webp',
            'web_version'           => '1.4.0',
        ];

        BasicSettings::firstOrCreate($data);
    }
}
