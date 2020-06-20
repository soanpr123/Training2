package com.fpt.my_travel;

import android.content.Intent;
import android.os.Bundle;
import vn.momo.momo_partner.AppMoMoLib;
import vn.momo.momo_partner.MoMoParameterNamePayment;

import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.annotation.TargetApi;
import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import android.widget.Toast;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;


import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.dev/battery";
    int environment = 1;
    public String amount = "10000";
    private String fee = "0";
    private String merchantName = "MOMO";
    private String merchantCode = "MOMO";
    private String merchantNameLabel = "GrapViet";
    private String description = "Nạp tiền vào ví";
    private String MOMO_WEB_SDK_DEV = "http://118.69.187.119:9090/sdk/api/v1/payment/request";//debug
    private int minAmount = 10000;
    private int choose = 0;
    private String momo = "0";
    CharSequence[] titles;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        if (call.method.equals("oPenMoMo")) {
                            String listmoney = call.argument("money").toString();
                            oPenMoMo(Double.parseDouble(listmoney));
                        }
                    }
                });
    }

    private void oPenMoMo(double money) {
        requestPayment(money);
    }


    private void requestPayment(Double moneyAdded) {
        if (true) {
            AppMoMoLib.getInstance().setEnvironment(AppMoMoLib.ENVIRONMENT.DEVELOPMENT);
            AppMoMoLib.getInstance().setAction(AppMoMoLib.ACTION.PAYMENT);
            AppMoMoLib.getInstance().setActionType(AppMoMoLib.ACTION_TYPE.GET_TOKEN);
            Map<String, Object> eventValue = new HashMap<>();
            eventValue.put(MoMoParameterNamePayment.MERCHANT_NAME, merchantName);
            eventValue.put(MoMoParameterNamePayment.MERCHANT_CODE, merchantCode);
            eventValue.put(MoMoParameterNamePayment.AMOUNT, moneyAdded);
            eventValue.put(MoMoParameterNamePayment.DESCRIPTION, description);
            eventValue.put(MoMoParameterNamePayment.FEE, fee);
            eventValue.put(MoMoParameterNamePayment.MERCHANT_NAME_LABEL, merchantNameLabel);
            eventValue.put(MoMoParameterNamePayment.REQUEST_ID, merchantCode + "-" + UUID.randomUUID().toString());

            eventValue.put("language", "vi");
            eventValue.put("submitURLWeb", MOMO_WEB_SDK_DEV);
            amount = moneyAdded + "";
            eventValue.put(MoMoParameterNamePayment.EXTRA, "");
            AppMoMoLib.getInstance().requestMoMoCallBack(this, eventValue);

        }
    }


    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (data.getStringExtra("message").equals("Successful")) {
            Toast.makeText(MainActivity.this, "Thanh toán thành công", Toast.LENGTH_SHORT).show();
        }

        Log.e("request status", data.getStringExtra("message") + "");

        if (requestCode == AppMoMoLib.getInstance().REQUEST_CODE_MOMO && resultCode == -1) {
            if (data != null) {
                if (data.getIntExtra("status", -1) == 0) {
                    //TOKEN IS AVAILABLE

                    Log.d("TAG", "message: " + "Get token " + data.getStringExtra("message"));
                    String token = data.getStringExtra("data"); //Token response
                    String phoneNumber = data.getStringExtra("phonenumber");
                    String env = data.getStringExtra("env");
                    if (env == null) {
                        env = "app";
                    }

                    if (token != null && !token.equals("")) {
                        // TODO: send phoneNumber & token to your server side to process payment with MoMo server
                        // IF Momo topup success, continue to process your order
                    } else {
//                        Log.d("TAG","message: " + this.getString(R.string.not_receive_info));
                    }
                } else if (data.getIntExtra("status", -1) == 1) {
                    //TOKEN FAIL
                    String message = data.getStringExtra("message") != null ? data.getStringExtra("message") : "Thất bại";
                    Log.d("TAG", "message: " + message);
                } else if (data.getIntExtra("status", -1) == 2) {
                    //TOKEN FAIL
//                    Log.d("message: " + this.getString(R.string.not_receive_info));
                } else {
                    //TOKEN FAIL
//                    Log.d("message: " + this.getString(R.string.not_receive_info));
                }
            } else {
//                Log.d("message: " + this.getString(R.string.not_receive_info));
            }
        } else {
//            Log.d("message: " + this.getString(R.string.not_receive_info_err));
        }
    }
}
