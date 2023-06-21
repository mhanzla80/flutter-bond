import 'dart:core';

import 'package:bond/core/app_notification_providers.dart';
import 'package:bond/core/notifications/push_notifications_providers/clevertap_push_notification_provider.dart';
import 'package:bond_core/core.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

import '../config/notification.dart';

class NotificationsServiceProvider extends ServiceProvider {
  @override
  Future<void> register(GetIt it) async {
    for (final provider in NotificationConfig.providers.entries) {
      final driver = provider.value['driver'] as String;
      switch (driver) {
        case 'push_notification':
          _registerPushNotification(provider, it);
          break;
        case 'notification_center':
          _registerServerNotification(provider, it);
      }
    }
  }

  void _registerPushNotification(
      MapEntry<String, Map<String, Object>> provider, GetIt it) {
    final channels = provider.value['channels'] as List<Map<String, dynamic>>;
    _registerChannels(channels, it);
    it.registerLazySingleton<PushNotificationsProviders>(
      () => PushNotificationsProviders(
        pushNotificationProviders: channels
            .map(
              (channel) => it<PushNotificationProvider>(
                instanceName: channel['name'],
              ),
            )
            .toList(),
      ),
    );
  }

  void _registerChannels(List<Map<String, dynamic>> channels, GetIt it) {
    for (final channel in channels) {
      final channelName = channel['name'] as String;
      switch (channelName) {
        case 'firebase_messaging':
          it.registerLazySingleton<PushNotificationProvider>(
            () => FirebaseMessagingNotificationProvider(
              FirebaseMessaging.instance,
            ),
            instanceName: channelName,
          );
          break;
        case 'clever_tap':
          it.registerLazySingleton<MarketingNotificationProvider>(
            () => CleverTapPushNotificationProvider(
              CleverTapPlugin(),
            ),
            instanceName: channelName,
          );
          break;
      }
    }

    sl<MarketingNotificationProvider>(instanceName: 'clever_tap').onPushNotification.listen((event) {

    });
  }

  void _registerServerNotification(
      MapEntry<String, Map<String, Object>> provider, GetIt it) {
    final dataSource = provider.value['data_source'] as Map<String, dynamic>;
    final dataSourceName = dataSource['name'] as String;
    switch (dataSourceName) {
      case 'notification_center_remote_data_source':
        it.registerFactory<NotificationCenterDataSource>(
          () => NotificationCenterRemoteDataSource(it()),
          instanceName: dataSourceName,
        );
        break;
    }
    it.registerLazySingleton<NotificationCenterProvider>(
      () => NotificationCenterProvider(
        pushNotificationProvider: it(instanceName: 'firebase_messaging'),
        notificationCenterDataSource:
            it(instanceName: 'notification_center_remote_data_source'),
      ),
    );
  }

  @override
  T? responseConvert<T>(Map<String, dynamic> json) {
    switch (T) {
      case ServerNotificationModel:
        return ServerNotificationModel.fromJson(json) as T;
      default:
        return null;
    }
  }
}
