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
    CleverTapPlugin.profileSet(attributes);
  }

  @override
  void setUserId(int userId) {
    CleverTapPlugin.profileSet({
      'user_id': userId,
    });
  }
}