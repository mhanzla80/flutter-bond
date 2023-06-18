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

  @override
  void logBeginTutorial() {
    CleverTapPlugin.recordEvent("BeginTutorial", {});
  }

  @override
  void logCompleteTutorial() {
    CleverTapPlugin.recordEvent("CompleteTutorial", {});
  }

  @override
  void logSignedIn(UserSignedIn event) {
    CleverTapPlugin.profileSet({
      'Identity': event.id.toString(),
      'id': event.id.toString(),
    });
    CleverTapPlugin.recordEvent(
        "UserSignedIn", {"loginMethod": event.loginMethod});
  }

  @override
  void logSignedUp(UserSignedUp event) {
    CleverTapPlugin.profileSet({
      'Identity': event.id.toString(),
      'id': event.id.toString(),
    });
    CleverTapPlugin.recordEvent(
        "UserSignedUp", {"signUpMethod": event.signupMethod});
  }

  @override
  void updateProfile(UserUpdateProfile event) {
    var props = {
      "name": event.name,
      "mobile": event.mobile,
      "email": event.email,
      "dob": event.dob,
      "gender": event.gender,
      "country": event.country,
      "city": event.city,
      "age": event.age.toString(),
    };

    CleverTapPlugin.profileSet(props);
  }

  @override
  void logViewItemList(UserViewedItemList event) {
    CleverTapPlugin.recordEvent("UserViewedItemList", {
      "items": event.items?.map((item) => item.analyticsEventItem).toList(),
      "itemListId": event.itemListId,
      "itemListName": event.itemListName,
    });
  }

  @override
  void logViewItem(UserViewItem event) {
    CleverTapPlugin.recordEvent("UserViewItem", {
      "currency": event.currency,
      "value": event.value,
      "items": event.items?.map((item) => item.analyticsEventItem).toList(),
    });
  }

  @override
  void logSelectItem(UserSelectItem event) {
    CleverTapPlugin.recordEvent("UserSelectItem", {
      "itemListId": event.itemListId,
      "itemListName": event.itemListName,
      "items": event.items.map((item) => item.analyticsEventItem).toList(),
    });
  }

  @override
  void logViewPromotion(UserViewPromotion event) {
    CleverTapPlugin.recordEvent("UserViewPromotion", {
      "promotionId": event.promotionId,
      "promotionName": event.promotionName,
      "creativeName": event.creativeName,
      "creativeSlot": event.creativeSlot,
      "items": event.items?.map((item) => item.analyticsEventItem).toList(),
    });
  }

  @override
  void logSelectPromotion(UserSelectPromotion event) {
    CleverTapPlugin.recordEvent("UserSelectPromotion", {
      "promotionId": event.promotionId,
      "promotionName": event.promotionName,
      "creativeName": event.creativeName,
      "creativeSlot": event.creativeSlot,
      "items": event.items?.map((item) => item.analyticsEventItem).toList(),
    });
  }

  @override
  void logAddToCart(UserAddedToCart event) {
    CleverTapPlugin.recordEvent("UserAddedToCart", {
      "items": event.items.map((item) => item.analyticsEventItem).toList(),
      "value": event.value,
      "currency": event.currency,
    });
  }

  @override
  void logRemoveFromCart(UserRemovedFromCart event) {
    CleverTapPlugin.recordEvent("UserRemovedFromCart", {
      "items": event.items.map((item) => item.analyticsEventItem).toList(),
      "value": event.value,
      "currency": event.currency,
    });
  }

  @override
  void logBeginCheckout(UserBeginCheckout event) {
    CleverTapPlugin.recordEvent("UserBeginCheckout", {
      "value": event.value,
      "currency": event.currency,
      "items": event.items.map((item) => item.analyticsEventItem).toList(),
    });
  }

  @override
  void logMadePurchase(UserMadePurchase event) {
    CleverTapPlugin.recordEvent("UserMadePurchase", {
      "transactionId": event.transactionId,
      "value": event.value,
      "tax": event.tax,
      "currency": event.currency,
      "coupon": event.coupon,
      "items":
          event.items.map((EventItem item) => item.analyticsEventItem).toList(),
    });
  }

  @override
  void logRefundOrder(UserRefundOrder event) {
    CleverTapPlugin.recordEvent("UserRefundOrder", {
      "transactionId": event.transactionId,
      "value": event.value,
      "tax": event.tax,
      "currency": event.currency,
      "coupon": event.coupon,
      "items":
          event.items.map((EventItem item) => item.analyticsEventItem).toList(),
    });
  }

  @override
  void logSearch(UserSearch event) {
    CleverTapPlugin.recordEvent("UserSearch", {
      "searchTerm": event.searchTerm,
    });
  }

  @override
  void logShareContent(UserShareContent event) {
    CleverTapPlugin.recordEvent("UserShareContent", {
      "contentType": event.contentType,
      "itemId": event.itemId,
      "method": event.method ?? 'unknown',
    });
  }

  @override
  void logViewSearchResults(UserViewSearchResult event) {
    CleverTapPlugin.recordEvent("UserViewSearchResult", {
      "searchTerm": event.searchTerm,
    });
  }
}
