import 'package:bond/core/app_analytics.dart';
import 'package:bond_core/core.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:flutter/cupertino.dart';

class CleverTapAnalyticsProvider extends AnalyticsProvider {
  @override
  void logEvent(AnalyticsEvent event) {
    if (event.key != null) {
      final String eventKey = event.key!.toLowerCase().replaceAll(' ', '_');
      CleverTapPlugin.recordEvent(eventKey, event.params);
    }
  }

  @override
  void setUserAttributes(Map<String, dynamic> attributes) {
    // TODO mapping with CleverTap Standers Attribute Names
    // Example of Attribute Names Identity instead of id or user_id, DOB (dd-MM-yyyy) use CleverTapPlugin.getCleverTapDate(new DateTime.now())
    attributes.forEach(_sendCustomAttributes);
  }

  @override
  void setUserId(int userId) {
    CleverTapPlugin.profileSet({
      'Identity': userId,
      'id': userId,
    });
  }

  void _sendCustomAttributes(String key, dynamic value) {
    var userPropertyKey = key.toLowerCase().replaceAll(' ', '_');
    debugPrint(
      'CleverTapAnalyticsProvider send custom user attribute with key: '
      '$userPropertyKey, '
      'value: $value and value type: ${value.runtimeType}',
    );
    if (value is DateTime) {
      final dobDate = CleverTapPlugin.getCleverTapDate(value);
      CleverTapPlugin.profileSet({
        userPropertyKey: dobDate,
      });
    } else if (value is String && (value == 'id' || value == 'user_id')) {
      CleverTapPlugin.profileSet({
        'Identity': value,
        'id': value,
      });
    } else {
      CleverTapPlugin.profileSet({
        userPropertyKey: value,
      });
    }
  }
}
