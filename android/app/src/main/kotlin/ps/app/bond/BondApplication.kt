package com.example.famcare

import com.clevertap.android.sdk.ActivityLifecycleCallback
import io.flutter.app.FlutterApplication

class BondApplication: FlutterApplication() {
    override fun onCreate() {
        ActivityLifecycleCallback.register(this)//<--- Add this before super.onCreate()
        super.onCreate()
    }
}