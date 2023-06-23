package ps.app.bond

import io.flutter.embedding.android.FlutterActivity
import com.clevertap.android.sdk.*
import android.content.Intent
import android.os.Build
import android.app.NotificationManager

import android.os.Bundle

class MainActivity : FlutterActivity() {
    var cleverTapDefaultInstance: CleverTapAPI? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        cleverTapDefaultInstance = CleverTapAPI.getDefaultInstance(this)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)

        // On Android 12, Raise notification clicked event when Activity is already running in activity backstack
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            cleverTapDefaultInstance?.pushNotificationClickedEvent(intent!!.extras)
        }
    }
}
