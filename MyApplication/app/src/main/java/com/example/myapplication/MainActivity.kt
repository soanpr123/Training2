package com.example.myapplication

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import vn.momo.momo_partner.AppMoMoLib
import vn.momo.momo_partner.MoMoParameterNameMap

class MainActivity : AppCompatActivity() {
    private String amount = "10000";
    private String fee = "0";
    int environment = 0;//developer default
    private String merchantName = "Demo SDK";
    private String merchantCode = "SCB01";
    private String merchantNameLabel = "Nhà cung cấp";
    private String description = "Thanh toán dịch vụ ABC";

    void onCreate(Bundle savedInstanceState)
    AppMoMoLib.getInstance().setEnvironment(AppMoMoLib.ENVIRONMENT.DEVELOPMENT); // AppMoMoLib.ENVIRONMENT.PRODUCTION
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }
}
