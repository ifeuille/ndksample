package com.loo.ndksample;

import android.app.NativeActivity;
import android.os.Bundle;

import java.util.concurrent.Semaphore;

public class NDKSampleActivity extends NativeActivity {

    static {
        // Load native library
        System.loadLibrary("ndksample_d");
    }
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    //private final Semaphore semaphore = new Semaphore(0, true);
}
