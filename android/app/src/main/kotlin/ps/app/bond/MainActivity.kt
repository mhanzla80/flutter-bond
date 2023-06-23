package ps.app.bond

import io.flutter.embedding.android.FlutterActivity
import com.clevertap.android.sdk.*
import android.content.Intent
import android.os.Build
import android.app.NotificationManager

import android.os.Bundle

class MainActivity : FlutterActivity(), PushPermissionResponseListener {
    var cleverTapDefaultInstance: CleverTapAPI? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        cleverTapDefaultInstance = CleverTapAPI.getDefaultInstance(this)
        cleverTapDefaultInstance?.registerPushPermissionNotificationResponseListener(this)
    }

    override fun onPushPermissionResponse(accepted: Boolean) {
        if (accepted) {
            CleverTapAPI.createNotificationChannel(
                    getApplicationContext(),
                    "famcare_ct",
                    "Famcare Marketing",
                    "Famcare Marketing Channel for CleverTap",
                    NotificationManager.IMPORTANCE_HIGH,
                    true
            );
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        cleverTapDefaultInstance?.unregisterPushPermissionNotificationResponseListener(this)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)

        // On Android 12, Raise notification clicked event when Activity is already running in activity backstack
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            cleverTapDefaultInstance?.pushNotificationClickedEvent(intent!!.extras)
        }
    }
}
