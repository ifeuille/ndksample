package com.loo.ndksample;

import android.app.NativeActivity;
import android.os.Bundle;


public class NDKSampleActivity extends NativeActivity {

    static {
        // Load native library
        System.loadLibrary("ndksample");
    }
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

}
