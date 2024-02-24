import 'package:entscheider_app/views/user_view.dart';
import 'package:flutter/material.dart';

import '../views/home_view.dart';

class AppRouter {
  static const String initialRoute = '/homeView';
  static const String userScreen = '/user';
  static Map<String, WidgetBuilder> routes = {
    userScreen: (context) => const UserView(),
    initialRoute: (context) => const HomeView(),
  };
}