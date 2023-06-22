import 'dart:async';

import 'package:bond_core/core.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';

class CleverTapInAppNotificationProvider {
  final CleverTapPlugin _cleverTapPlugin;
  final StreamController<NotificationData>
      _marketingInAppNotificationController =
      StreamController<Map<String, dynamic>>.broadcast();

  CleverTapInAppNotificationProvider(this._cleverTapPlugin);

  Stream<NotificationData> get onInAppNotification {
    _cleverTapPlugin.setCleverTapInAppNotificationButtonClickedHandler(
      (Map<String, dynamic>? payload) {
        _marketingInAppNotificationController.add(payload ?? {});
      },
    );
    return _marketingInAppNotificationController.stream;
  }

  Stream<NotificationData> get onInAppNotificationTapped {
    _cleverTapPlugin.setCleverTapInAppNotificationDismissedHandler((
      Map<String, dynamic> payload,
    ) {
      _marketingInAppNotificationController.add(payload);
    });
    return _marketingInAppNotificationController.stream;
  }

  Stream<NotificationData> get onInAppNotificationDismiss {
    _cleverTapPlugin.setCleverTapInAppNotificationShowHandler((
      Map<String, dynamic> payload,
    ) {
      _marketingInAppNotificationController.add(payload);
    });
    return _marketingInAppNotificationController.stream;
  }

  Future<void> suspendInAppNotifications() async {
    return null;
  }

  static Future<void> discardInAppNotifications() async {
    return null;
  }

  static Future<void> resumeInAppNotifications() async {
    return null;
  }
}
