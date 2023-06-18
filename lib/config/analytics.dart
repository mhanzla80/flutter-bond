import 'package:bond/core/app_analytics.dart';
import 'package:bond/core/app_analytics_providers/clevertap_analytics_provider.dart';

class AnalyticsConfig {
  static var providers = {
    'firebase_analytics_provider': {
      'driver': 'firebase_analytics_provider',
      'class': FirebaseAnalyticsProvider,
    },
    'clever_tap_analytics_provider': {
      'driver': 'clever_tap_analytics_provider',
      'class': CleverTapAnalyticsProvider,
    },
  };
}
