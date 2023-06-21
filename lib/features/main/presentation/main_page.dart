import 'dart:convert';

import 'package:bond/features/update_app/update_app_service.dart';
import 'package:bond_core/core.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    sl<UpdateAppService>().showSoftUpdate();
    // initPlatformState();
    activateCleverTapFlutterPluginHandlers();
    CleverTapPlugin.setDebugLevel(3);
    CleverTapPlugin.createNotificationChannel(
        "fluttertest", "Flutter Test", "Flutter Test", 3, true);
    CleverTapPlugin.initializeInbox();
    CleverTapPlugin.registerForPush(); //only for iOS
    var initialUrl = CleverTapPlugin.getInitialUrl();
    print('ttt _MyAppState.initState initialUrl ${initialUrl}');
  }

  void activateCleverTapFlutterPluginHandlers() {
    CleverTapPlugin clevertapPlugin;
    clevertapPlugin = CleverTapPlugin();

    clevertapPlugin.setCleverTapPushAmpPayloadReceivedHandler(
      pushAmpPayloadReceived,
    );
    clevertapPlugin.setCleverTapPushClickedPayloadReceivedHandler(
      pushClickedPayloadReceived,
    );
    clevertapPlugin.setCleverTapPushPermissionResponseReceivedHandler(
      pushPermissionResponseReceived,
    );

    clevertapPlugin.setCleverTapInAppNotificationDismissedHandler(
      inAppNotificationDismissed,
    );
    clevertapPlugin.setCleverTapInAppNotificationShowHandler(
      inAppNotificationShow,
    );
    clevertapPlugin.setCleverTapInAppNotificationButtonClickedHandler(
      inAppNotificationButtonClicked,
    );
    // clevertapPlugin
    //     .setCleverTapProfileDidInitializeHandler(profileDidInitialize);
    // clevertapPlugin.setCleverTapProfileSyncHandler(profileDidUpdate);
    // clevertapPlugin.setCleverTapInboxDidInitializeHandler(inboxDidInitialize);
    // clevertapPlugin
    //     .setCleverTapInboxMessagesDidUpdateHandler(inboxMessagesDidUpdate);
    // clevertapPlugin
    //     .setCleverTapDisplayUnitsLoadedHandler(onDisplayUnitsLoaded);

    // clevertapPlugin.setCleverTapInboxNotificationButtonClickedHandler(
    //     inboxNotificationButtonClicked);
    // clevertapPlugin.setCleverTapInboxNotificationMessageClickedHandler(
    //     inboxNotificationMessageClicked);
    // clevertapPlugin.setCleverTapFeatureFlagUpdatedHandler(featureFlagsUpdated);
    // clevertapPlugin
    //     .setCleverTapProductConfigInitializedHandler(productConfigInitialized);
    // clevertapPlugin
    //     .setCleverTapProductConfigFetchedHandler(productConfigFetched);
    // clevertapPlugin
    //     .setCleverTapProductConfigActivatedHandler(productConfigActivated);
  }

  void localHalfInterstitialPushPrimer() {
    var pushPrimerJSON = {
      'inAppType': 'half-interstitial',
      'titleText': 'Get Notified',
      'messageText':
          'Please enable notifications on your device to use Push Notifications.',
      'followDeviceOrientation': false,
      'positiveBtnText': 'Allow',
      'negativeBtnText': 'Cancel',
      'fallbackToSettings': true,
      'backgroundColor': '#FFFFFF',
      'btnBorderColor': '#000000',
      'titleTextColor': '#000000',
      'messageTextColor': '#000000',
      'btnTextColor': '#000000',
      'btnBackgroundColor': '#FFFFFF',
      'btnBorderRadius': '4',
      'imageUrl':
          'https://icons.iconarchive.com/icons/treetog/junior/64/camera-icon.png'
    };
    CleverTapPlugin.promptPushPrimer(pushPrimerJSON);
  }

  void localAlertPushPrimer() async{
      bool? isPushPermissionEnabled = await CleverTapPlugin
          .getPushNotificationPermissionStatus();
      if (isPushPermissionEnabled == null) return;

      // Check Push Permission status and then call `promptPushPrimer` if not enabled.
      if (!isPushPermissionEnabled) {
        var pushPrimerJSON = {
          'inAppType': 'alert',
          'titleText': 'Get Notified',
          'messageText': 'Enable Notification permission',
          'followDeviceOrientation': true,
          'positiveBtnText': 'Allow',
          'negativeBtnText': 'Cancel',
          'fallbackToSettings': true
        };
        CleverTapPlugin.promptPushPrimer(pushPrimerJSON);
      } else {
        print("Push Permission is already enabled.");
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Text("Local Half Interstitial Push Primer"),
                  onTap: localHalfInterstitialPushPrimer,
                ),
              ),
            ), Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Text("Alert Push Primer"),
                  onTap: localAlertPushPrimer,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Text("getCleverTapId"),
                  onTap: getCleverTapId,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getCleverTapId() {
    CleverTapPlugin.getCleverTapID().then((clevertapId) {
      if (clevertapId == null) return;
      setState((() {
        print("$clevertapId");
      }));
    }).catchError((error) {
      setState(() {
        print("$error");
      });
    });
  }

  void pushAmpPayloadReceived(Map<String, dynamic> map) {
    print("ctap pushAmpPayloadReceived called");
    setState(() async {
      var data = jsonEncode(map);
      print("ctap Push Amp Payload = " + data.toString());
      CleverTapPlugin.createNotification(data);
    });
  }

  void pushClickedPayloadReceived(Map<String, dynamic> map) {
    print("ctap pushClickedPayloadReceived called");
    CleverTapPlugin.pushNotificationClickedEvent(map);
    setState(() async {
      var data = jsonEncode(map);
      print("ctap on Push Click Payload = " + data.toString());
    });
  }

  void pushPermissionResponseReceived(bool accepted) {
    print(
        "ctap Push Permission response called ---> accepted = ${accepted ? "true" : "false"}");
  }

  void inAppNotificationDismissed(Map<String, dynamic> map) {
    setState(() {
      print("ctap inAppNotificationDismissed called");
      // Uncomment to print payload.
      printInAppNotificationDismissedPayload(map);
    });
  }

  void printInAppNotificationDismissedPayload(Map<String, dynamic>? map) {
    if (map != null) {
      var extras = map['extras'];
      var actionExtras = map['actionExtras'];
      print("ctap InApp -> dismissed with extras map: ${extras.toString()}");
      print(
          "ctap InApp -> dismissed with actionExtras map: ${actionExtras.toString()}");
      actionExtras.forEach((key, value) {
        print("ctap Value for key: ${key.toString()} is: ${value.toString()}");
      });
    }
  }

  void inAppNotificationShow(Map<String, dynamic> map) {
    this.setState(() {
      print("ctap inAppNotificationShow called = ${map.toString()}");
    });
  }

  void inAppNotificationButtonClicked(Map<String, dynamic>? map) {
    this.setState(() {
      print("ctap inAppNotificationButtonClicked called = ${map.toString()}");
      // Uncomment to print payload.
      // printInAppButtonClickedPayload(map);
    });
  }
}
