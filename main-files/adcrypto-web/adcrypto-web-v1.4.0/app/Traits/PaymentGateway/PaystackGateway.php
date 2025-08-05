<?php 
namespace App\Traits\PaymentGateway;

use Exception;
use App\Models\User;
use App\Models\UserWallet;
use App\Models\Transaction;
use App\Models\TemporaryData;
use App\Constants\GlobalConst;
use App\Models\UserNotification;
use Illuminate\Support\Facades\DB;
use App\Models\Admin\BasicSettings;
use App\Constants\PaymentGatewayConst;
use App\Models\Admin\PaymentGatewayCurrency;
use Illuminate\Support\Facades\Notification;
use App\Notifications\User\AddMoneyNotification;
use App\Notifications\User\BuyCryptoMailNotification;
use App\Notifications\User\PaystackEmailNotification;

trait PaystackGateway {
    
    public function paystackInit($output = null) {
        $gateway = new \stdClass();
        
        foreach ($output['gateway']->credentials as $credential) {
            if ($credential->name === 'secret-key') {
                $gateway->secret_key = $credential->value;
            } elseif ($credential->name === 'email') {
                $gateway->email = $credential->value;
            }
        }
       
        $amount = get_amount($output['amount']->total_amount, null, 2) * 100;
        $temp_record_token = generate_unique_string('temporary_datas','identifier',60);
        $junkData       = $this->paystackJunkInsert($output,$temp_record_token);
        $url = "https://api.paystack.co/transaction/initialize";
        if(get_auth_guard() == 'api'){
            $fields             = [
                'email'         => auth()->user()->email,
                'amount'        => $amount,
                'currency'      => $output['currency']->code,
                'callback_url'  => route('api.paystack.pay.callback'). '?output='. $junkData->identifier
            ];
        }else{
            $fields             = [
                'email'         => auth()->user()->email,
                'amount'        => $amount,
                'currency'      => $output['currency']->code,
                'callback_url'  => route('paystack.pay.callback'). '?output='. $junkData->identifier
            ];
        }

        

        $fields_string = http_build_query($fields);

        //open connection
        $ch = curl_init();
        
        //set the url, number of POST vars, POST data
        curl_setopt($ch,CURLOPT_URL, $url);
        curl_setopt($ch,CURLOPT_POST, true);
        curl_setopt($ch,CURLOPT_POSTFIELDS, $fields_string);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            "Authorization: Bearer $gateway->secret_key",
            "Cache-Control: no-cache",
        ));
        
        //So that curl_exec returns the contents of the cURL; rather than echoing it
        curl_setopt($ch,CURLOPT_RETURNTRANSFER, true); 
        
        //execute post
        $result = curl_exec($ch);
        $response   = json_decode($result);
        
        if($response->status == true) {
            if(get_auth_guard() == 'api'){
                
                $response->data = [
                    'redirect_url' => $response->data->authorization_url,
                    'redirect_links' => '',
                    'gateway_type' => PaymentGatewayConst::AUTOMATIC,
                    'access_code' => $response->data->access_code,
                    'reference' => $response->data->reference,
                ];
                return $response->data;
            }else{
                return redirect($response->data->authorization_url)->with('output',$output);
            }
        } else {
            $output['status'] = 'error';
            $output['message'] = $response->message;
            return back()->with(['error' => [$output['message']]]);
        }
    }
    /**
     * function for junk insert
     */
    public function paystackJunkInsert($output,$temp_identifier){
        $output = $this->output;
        $data = [
            'gateway'       => $output['gateway']->id,
            'currency'      => $output['currency']->id,
            'amount'        => json_decode(json_encode($output['amount']),true),
            'response'      => $output,
            'wallet_table'  => $output['wallet']->getTable(),
            'wallet_id'     => $output['wallet']->id,
            'creator_table' => auth()->guard(get_auth_guard())->user()->getTable(),
            'creator_id'    => auth()->guard(get_auth_guard())->user()->id,
            'creator_guard' => get_auth_guard(),
            'user_record'   => $output['form_data']['identifier'],
        ];
       
        return TemporaryData::create([
            'type'          => PaymentGatewayConst::BUY_CRYPTO,
            'identifier'    => $temp_identifier,
            'data'          => $data,
        ]);
    }
    // function paystack success
    function paystackSuccess($request){
        $reference = $request['reference'];
        $identifier = $request['output'];
        $temp_data  = TemporaryData::where('identifier',$identifier)->first();
  
        $curl = curl_init();
        $secret_key = '';
        foreach ($temp_data->data->response->gateway->credentials as $credential) {
            if ($credential->name === 'secret-key') {
                $secret_key = $credential->value;
                break;
            }
        }
        curl_setopt_array($curl, array(
          CURLOPT_URL => "https://api.paystack.co/transaction/verify/$reference",
          CURLOPT_RETURNTRANSFER => true,
          CURLOPT_ENCODING => "",
          CURLOPT_MAXREDIRS => 10,
          CURLOPT_TIMEOUT => 30,
          CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
          CURLOPT_CUSTOMREQUEST => "GET",
          CURLOPT_HTTPHEADER => array(
            "Authorization: Bearer $secret_key",
            "Cache-Control: no-cache",
          ),
        ));
        
        $result = curl_exec($curl);
        $response   = json_decode($result);
        $responseArray = [
            'type' => $temp_data->data->response->type,
            'gateway' => $temp_data->data->response->gateway, // Converts the object to an array
            'currency' => $temp_data->data->response->currency, // Converts the object to an array
            'amount' => $temp_data->data->response->amount, // Converts the object to an array
            'form_data' => [
                'identifier' => $temp_data->identifier
            ], 
            // Assuming this is already an array
            'distribute' => $temp_data->data->response->distribute,
            'record_handler' => $temp_data->data->response->record_handler,
            'capture' => $response->data->reference,
            'junk_indentifier' => $identifier
        ];
        
        if($response->status == true){
            try{
                $transaction_response = $this->createTransaction($responseArray);
            }catch(Exception $e) {
                throw new Exception($e->getMessage());
            }
            return $transaction_response;
        }
    }
    // Update Code (Need to check)
    public function createTransaction($output, $temp_remove = true) {
        $basic_settings = BasicSettings::first();
        $record_handler = $output['record_handler'];
        $data = TemporaryData::where('identifier',$output['form_data']['identifier'])->first();
        $temp_data = TemporaryData::where('identifier',$data->data->user_record)->first();
        $user = User::where('id',$data->data->creator_id)->first();
        
        $inserted_id = $this->$record_handler($output,$status = GlobalConst::STATUS_CONFIRM_PAYMENT);
        $transaction  = Transaction::with(['currency'])->where('id',$inserted_id)->first();
        
        if($basic_settings->email_notification == true){
            Notification::route("mail",$user->email)->notify(new PaystackEmailNotification($user,$temp_data,$transaction->trx_id));
        }
        


        UserNotification::create([
            'user_id'       => $user->id,
            'message'       => [
                'title'     => "Buy Crypto",
                'payment'   => $transaction->currency->name,
                'wallet'    => $temp_data->data->wallet->name,
                'code'      => $temp_data->data->wallet->code,
                'amount'    => $transaction->amount,
                'status'    => $transaction->status,
                'success'   => "Successfully Added."
            ],
        ]);

        
        if($temp_remove == true) {
            $this->removeTempData($output);
        }
        if($this->requestIsApiUser()) {
            // logout user
            $api_user_login_guard = $this->output['api_login_guard'] ?? null;
            if($api_user_login_guard != null) {
                auth()->guard($api_user_login_guard)->logout();
            }
        }
        
    }
    public function requestIsApiUser() {
        $request_source = request()->get('r-source');
        if($request_source != null && $request_source == PaymentGatewayConst::APP) return true;
        return false;
    }
    

    public function insertRecordWeb($output, $status) {
        $data  = TemporaryData::where('identifier',$output['form_data']['identifier'])->first();
        
        $user = auth()->guard('web')->user();
        $temp_data = TemporaryData::where('identifier',$data->data->user_record)->first();
        
        $user_wallet = UserWallet::where('id',$temp_data->data->wallet->wallet_id)->first();
        $payment_gateway = PaymentGatewayCurrency::where('id',$data->data->currency)->first();
       
        $trx_id = generateTrxString("transactions","trx_id","BC",8);
       
        DB::beginTransaction();
        try{
            $id = DB::table("transactions")->insertGetId([
                'type'                          => $output['type'],
                'user_id'                       => $user->id,
                'user_wallet_id'                => $data->data->wallet_id,
                'payment_gateway_currency_id'   => $data->data->currency,
                'trx_id'                        => $trx_id,
                'amount'                        => $data->data->amount->requested_amount,
                'fixed_charge'                  => $data->data->amount->fixed_charge,
                'percent_charge'                => $data->data->amount->percent_charge,
                'total_charge'                  => $data->data->amount->total_charge,
                'total_payable'                 => $data->data->amount->total_amount,
                'available_balance'             => $user_wallet->balance + $data->data->amount->requested_amount,
                'currency_code'                 => $payment_gateway->currency_code,
                'remark'                        => ucwords(remove_special_char($output['type']," ")) . " With " . $payment_gateway->name,
                'details'                       => json_encode(['gateway_response' => $output['capture'],'data' => $temp_data->data]),
                'status'                        => $status,
                'callback_ref'                  => $output['callback_ref'] ?? null,
                'created_at'                    => now(),
            ]);
            if($temp_data->data->wallet->type == global_const()::INSIDE_WALLET){
                if($status === GlobalConst::STATUS_CONFIRM_PAYMENT) {
                    $this->updateWalletBalance($user_wallet,$data->data->amount->requested_amount);
                }
            }
            DB::commit();
        }catch(Exception $e) {
            DB::rollBack();
            throw new Exception($e->getMessage());
        }
        return $id;
    }
    public function updateWalletBalance($user_wallet,$amount) {
        $update_amount = $user_wallet->balance + $amount;

        $user_wallet->update([
            'balance'   => $update_amount,
        ]);
    }
    public function insertRecordApi($output, $status) {
        $data  = TemporaryData::where('identifier',$output['form_data']['identifier'])->first();
       
        $temp_data = TemporaryData::where('identifier',$data->data->user_record)->first();
       
        $user = User::where('id',$data->data->creator_id)->first();

        $user_wallet = UserWallet::where('id',$temp_data->data->wallet->wallet_id)->first();
        $payment_gateway = PaymentGatewayCurrency::where('id',$data->data->currency)->first();

        $trx_id = generateTrxString("transactions","trx_id","BC",8);
    
        DB::beginTransaction();
        try{
            $id = DB::table("transactions")->insertGetId([
                'type'                          => $output['type'],
                'user_id'                       => $user->id,
                'user_wallet_id'                => $data->data->wallet_id,
                'payment_gateway_currency_id'   => $data->data->currency,
                'trx_id'                        => $trx_id,
                'amount'                        => $data->data->amount->requested_amount,
                'fixed_charge'                  => $data->data->amount->fixed_charge,
                'percent_charge'                => $data->data->amount->percent_charge,
                'total_charge'                  => $data->data->amount->total_charge,
                'total_payable'                 => $data->data->amount->total_amount,
                'available_balance'             => $user_wallet->balance + $data->data->amount->requested_amount,
                'currency_code'                 => $payment_gateway->currency_code,
                'remark'                        => ucwords(remove_special_char($output['type']," ")) . " With " . $payment_gateway->name,
                'details'                       => json_encode(['gateway_response' => $output['capture'],'data' => $temp_data->data]),
                'status'                        => $status,
                'callback_ref'                  => $output['callback_ref'] ?? null,
                'created_at'                    => now(),
            ]);
            if($temp_data->data->wallet->type == global_const()::INSIDE_WALLET){
                if($status === GlobalConst::STATUS_CONFIRM_PAYMENT) {
                    $this->updateWalletBalance($user_wallet,$data->data->amount->requested_amount);
                }
            }
            DB::commit();
        }catch(Exception $e) {
            DB::rollBack();
            throw new Exception($e->getMessage());
        }
        return $id;
    }

    public function removeTempData($output) {
        try{
            $id = $output['tempData']['id'];
            TemporaryData::find($id)->delete();
        }catch(Exception $e) {
            // handle error
        }
    }
    
}


?>