import 'dart:async';

import 'package:bond_core/core.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';

class CleverTapPushNotificationProvider extends MarketingNotificationProvider
    with ChannelableNotification {
  final CleverTapPlugin _cleverTapPlugin;
  final StreamController<NotificationData> _marketingNotificationController =
      StreamController<Map<String, dynamic>>.broadcast();

  CleverTapPushNotificationProvider(this._cleverTapPlugin);

  @override
  Future<void> createNotification(data) {
    return CleverTapPlugin.createNotification(data);
  }

  @override
  Future<void> createNotificationChannel({
    required String channelId,
    required String channelName,
    required String channelDescription,
    required int importance,
    required bool showBadge,
    String? sound,
    String? groupId,
  }) {
    return CleverTapPlugin.createNotificationChannel(
      channelId,
      channelName,
      channelDescription,
      importance,
      showBadge,
    );
  }

  @override
  Future<void> createNotificationChannelGroup(
    String groupId,
    String groupName,
  ) {
    return CleverTapPlugin.createNotificationChannelGroup(groupId, groupName);
  }

  @override
  Future<void> deleteNotificationChannel(String channelId) {
    return CleverTapPlugin.deleteNotificationChannel(channelId);
  }

  @override
  Future<void> deleteNotificationChannelGroup(String groupId) {
    return CleverTapPlugin.deleteNotificationChannelGroup(groupId);
  }

  @override
  Future<NotificationData?> get initialNotification async{
    final initialLink = await CleverTapPlugin.getInitialUrl();
    return Future.value({"link": initialLink});
  }

  @override
  Stream<NotificationData> get onPushNotification {
    _cleverTapPlugin.setCleverTapPushClickedPayloadReceivedHandler((
      Map<String, dynamic> payload,
    ) {
      _marketingNotificationController.add(payload);
    });
    return _marketingNotificationController.stream;
  }

  @override
  Stream<NotificationData> get onPushNotificationTapped =>
      _marketingNotificationController.stream;
}
