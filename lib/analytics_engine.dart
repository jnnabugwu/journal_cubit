import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsEngine {
    static final _instance = FirebaseAnalytics.instance;

  static void userLogsIn(String loginMethod)async{
      return _instance.logLogin(loginMethod: loginMethod);
  }

}