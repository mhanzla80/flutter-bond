import 'package:auto_route/auto_route.dart';
import 'package:bond/core/app_localizations.dart';
import 'package:bond/features/update_app/update_app_service.dart';
import 'package:bond/routes/app_router.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:flutter/material.dart';
import 'package:bond_core/core.dart';

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
    var stuff = ["mobile", "web"];
    var profile = {
      'Name': 'Ismail Amassi',
      'Identity': '100',
      'Email': 'ismail@famcare.app',
      'Phone': '+970592182025',
      'stuff': stuff
    };
    CleverTapPlugin.onUserLogin(profile);
    CleverTapPlugin.profileSet(profile);
    CleverTapPlugin.createNotificationChannel("fluttertest", "Flutter Test", "Flutter Test", 3, true);

    Future.delayed(const Duration(seconds: 5),(){
      CleverTapPlugin.getCleverTapID().then((clevertapId) {
        setState((() {
          print("ctap success $clevertapId");
        }));
      }).catchError((error) {
        setState(() {
          print("ctap error $error");
        });
      });
    });


    Future.delayed(const Duration(seconds: 5),(){
      var pushPrimerJSON = {
        'inAppType': 'half-interstitial',
        'titleText': 'Get Notified',
        'messageText': 'Please enable notifications on your device to use Push Notifications.',
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
        'imageUrl': 'https://icons.iconarchive.com/icons/treetog/junior/64/camera-icon.png'
      };
      CleverTapPlugin.promptPushPrimer(pushPrimerJSON);
    });


  }

  @override
  Widget build(BuildContext context) {

    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        MoreRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: context.localizations.navigation_bar_home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.collections),
                label: context.localizations.navigation_bar_collections,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.more_horiz),
                label: context.localizations.navigation_bar_more,
              ),
            ],
          ),
        );
      },
    );
  }
}
