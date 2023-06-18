import 'package:bond/core/app_analytics.dart';
import 'package:bond_core/core.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';

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
    CleverTapPlugin.profileSet(attributes);
  }

  @override
  void setUserId(int userId) {
    CleverTapPlugin.profileSet({
      'Identity': userId,
      'id': userId,
    });
  }

}
