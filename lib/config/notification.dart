import 'package:bond/core/app_notification_providers.dart';
import 'package:bond/core/notifications/push_notifications_providers/clevertap_push_notification_provider.dart';
import 'package:bond_core/core.dart';

class NotificationConfig {
  static var providers = {
    'push_notification': {
      'driver': 'push_notification',
      'class': PushNotificationsProviders,
      'channels': [
        {
          'name': 'firebase_messaging',
          'class': FirebaseMessagingNotificationProvider,
        },
        {
          'name': 'clever_tap',
          'class': CleverTapPushNotificationProvider,
        },
      ],
    },
    'server_notification': {
      'driver': 'notification_center',
      'data_source': {
        'name': 'notification_center_remote_data_source',
        'class': NotificationCenterRemoteDataSource,
      },
      'class': NotificationCenterProvider,
    }
  };
}
