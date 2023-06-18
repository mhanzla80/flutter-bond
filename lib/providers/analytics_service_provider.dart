import 'package:bond/core/app_analytics.dart';
import 'package:bond/core/app_analytics_providers/clevertap_analytics_provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:bond_core/core.dart';

import '../config/analytics.dart';

class AnalyticsServiceProvider extends ServiceProvider {
  @override
  Future<void> register(GetIt it) async {
    AnalyticsConfig.providers.forEach(
      (key, value) {
        if (value['driver'] == 'firebase_analytics_provider') {
          it.registerFactory<AnalyticsProvider>(
            () => FirebaseAnalyticsProvider(FirebaseAnalytics.instance),
            instanceName: 'firebase_analytics_provider',
          );
        } else if (value['driver'] == 'clever_tap_analytics_provider') {
          it.registerFactory<AnalyticsProvider>(
            () => CleverTapAnalyticsProvider(),
            instanceName: 'clever_tap_analytics_provider',
          );
        }
      },
    );
  }
}
