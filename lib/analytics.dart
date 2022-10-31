import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService extends ChangeNotifier{
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> setCurrentScreen(String screen) async {
    print('Setting current screen to $screen');
    await analytics.setCurrentScreen(
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

  Future logColorCopy({bool hex=true}) async {
    await analytics.logEvent(
      name: 'Copy color',
      parameters: {'type': hex?"Hex":"RGBA",},
    );
  }

  Future logUploadImage({required String image, required String type,}) async {
    await analytics.logEvent(
      name: 'Upload image',
      parameters: {'name': image, 'type': type,},
    );
  }

  Future logDragDrop({required String image, required String type,}) async {
    await analytics.logEvent(
      name: 'Drag & Drop image',
      parameters: {'name': image, 'type': type,},
    );
  }

  Future logSocial({required String social, }) async {
    await analytics.logEvent(
      name: 'Social clicked',
      parameters: {'social': social,},
    );
  }

  Future logLinkClicked({required String linkTitle, }) async {
    await analytics.logEvent(
      name: 'Link clicked',
      parameters: {'link': linkTitle,},
    );
  }

 /// ///////////////////////////////////////////////////////////////////////////////////////////////

  Future logColorChanged() async {
    await analytics.logEvent(
      name: 'Gradient color changed',
    );
  }

  Future logColorAdded() async {
    await analytics.logEvent(
      name: 'New gradient color',
    );
  }

  Future logColorRemoved() async {
    await analytics.logEvent(
      name: 'Remove gradient color',
    );
  }

  Future logAngleChanged() async {
    await analytics.logEvent(
      name: 'Angle changed',
    );
  }

  Future logGradientTypeChanged({required String type, }) async {
    await analytics.logEvent(
      name: 'GradientType changed',
      parameters: {'type': type,},
    );
  }

  Future logShareCode({required int gradCount, required int type, bool copyCSS=false}) async {
    String gradType="";
    switch(type){
      case 0: gradType="Linear Gradient";
      break;
      case 1: gradType="Radial Gradient";
      break;
      case 2: gradType="Sweep Gradient";
      break;
    }
    await analytics.logEvent(
      name: 'Design shared',
      parameters: {'gradCount': gradCount, 'gradType': gradType, 'copyCSS': copyCSS},
    );
  }
}
