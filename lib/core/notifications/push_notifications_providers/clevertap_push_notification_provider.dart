import 'package:bond_core/core.dart';

class CleverTapPushNotificationProvider extends PushNotificationProvider{
  @override
  // TODO: implement apnsToken
  Future<String?> get apnsToken => throw UnimplementedError();


  @override
  // TODO: implement initialNotification
  Future<NotificationData?> get initialNotification => throw UnimplementedError();

  @override
  // TODO: implement onPushNotification
  Stream<NotificationData> get onPushNotification => throw UnimplementedError();

  @override
  // TODO: implement onPushNotificationTapped
  Stream<NotificationData> get onPushNotificationTapped => throw UnimplementedError();

  @override
  // TODO: implement onTokenRefresh
  Stream<String> get onTokenRefresh => throw UnimplementedError();

  @override
  // TODO: implement token
  Future<String?> get token => throw UnimplementedError();

  @override
  Future<void> deleteToken() {
    // TODO: implement deleteToken
    throw UnimplementedError();
  }

}