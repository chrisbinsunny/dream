import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService extends ChangeNotifier{
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> setCurrentScreen(String screen) {
    print('Setting current screen to $screen');
    return analytics.setCurrentScreen(
      screenName: screen,
    );
  }

  // User properties tells us what the user is
  Future setUserProperties({ required String value, required String name}) async {
    await analytics.setUserProperty(name: name, value: value);
  }

  Future setUserId({required String userId,}) async {
    await analytics.setUserId(id: userId);
  }

  Future logLogin(String method) async {
    await analytics.logLogin(loginMethod: method);
  }

  Future logSignUp(String method) async {
    await analytics.logSignUp(signUpMethod: method);
  }

  Future logColorCopy({required String color, bool hex=true}) async {
    await analytics.logEvent(
      name: 'Copy color',
      parameters: {'color': color, 'hex': hex,},
    );
  }

  Future logUploadImage({required String image, required String type,}) async {
    await analytics.logEvent(
      name: 'Upload image',
      parameters: {'name': image, 'type': type,},
    );
  }

  Future logUploadImage({required String image, required String type,}) async {
    await analytics.logEvent(
      name: 'Upload image',
      parameters: {'name': image, 'type': type,},
    );
  }
}
