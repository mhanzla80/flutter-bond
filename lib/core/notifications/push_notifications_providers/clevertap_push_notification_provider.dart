import 'dart:async';

import 'package:bond_core/core.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';

class CleverTapPushNotificationProvider {
  final CleverTapPlugin _cleverTapPlugin;
  final StreamController<NotificationData> _pushNotificationTappedController =
      StreamController<Map<String, dynamic>>.broadcast();

  CleverTapPushNotificationProvider(this._cleverTapPlugin);

  get onPushNotification {
    // CleverTapPlugin.pushNotificationClickedEvent();
  }

  Stream<NotificationData> get onPushNotificationTapped {
    _cleverTapPlugin.setCleverTapPushClickedPayloadReceivedHandler((
      Map<String, dynamic> payload,
    ) {
      _pushNotificationTappedController.add(payload);
    });
    return _pushNotificationTappedController.stream;
  }
}
