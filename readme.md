

android_gradle is the android solution dir.
The generate debug apk is in android_gradle/build/output/apk.


We can use the 'apktool.' to decompress the apk and find the generate .s -- 'ndksample/lib/armeabi-v7a/libndksample_d.so'.

This is the log:
````
java.lang.UnsatisfiedLinkError: dalvik.system.PathClassLoader[DexPathList[[zip file "/data/app/com.loo.ndksample-U4h155_dYagqy_hhBpwwwg==/base.apk"],nativeLibraryDirectories=[/data/app/com.loo.ndksample-U4h155_dYagqy_hhBpwwwg==/lib/arm, /data/app/com.loo.ndksample-U4h155_dYagqy_hhBpwwwg==/base.apk!/lib/armeabi-v7a, /system/lib, /hw_product/lib]]] couldn't find "libndksample.so"
03-06 09:18:47.895 E/AndroidRuntime(12466):     at java.lang.Runtime.loadLibrary0(Runtime.java:1067)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at java.lang.Runtime.loadLibrary0(Runtime.java:1007)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at java.lang.System.loadLibrary(System.java:1668)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at com.loo.ndksample.NDKSampleActivity.<clinit>(NDKSampleActivity.java:12)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at java.lang.Class.newInstance(Native Method)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at android.app.AppComponentFactory.instantiateActivity(AppComponentFactory.java:95)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at android.support.v4.app.CoreComponentFactory.instantiateActivity(CoreComponentFactory.java:43)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at android.app.Instrumentation.newActivity(Instrumentation.java:1257)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at android.app.ActivityThread.performLaunchActivity(ActivityThread.java:3663)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at android.app.ActivityThread.handleLaunchActivity(ActivityThread.java:3939)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at android.app.servertransaction.LaunchActivityItem.execute(LaunchActivityItem.java:91)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at android.app.servertransaction.TransactionExecutor.executeCallbacks(TransactionExecutor.java:149)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at android.app.servertransaction.TransactionExecutor.execute(TransactionExecutor.java:103)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at android.app.ActivityThread$H.handleMessage(ActivityThread.java:2373)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at android.os.Handler.dispatchMessage(Handler.java:107)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at android.os.Looper.loop(Looper.java:213)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at android.app.ActivityThread.main(ActivityThread.java:8147)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at java.lang.reflect.Method.invoke(Native Method)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:513)
03-06 09:18:47.895 E/AndroidRuntime(12466):     at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:1101)

````

I also tried 'System.loadLibrary("ndksample_d");'.Same log output.

I'm sure the POSTFIX is the problem because the release version work well.


