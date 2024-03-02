import 'package:entscheider_app/views/history_view.dart';
import 'package:entscheider_app/views/user_view.dart';
import 'package:flutter/material.dart';

import '../views/home_view.dart';

class AppRouter {
  static const String initialRoute = '/home';
  static const String historyScreen = '/history';
  static const String userScreen = '/user';
  static Map<String, WidgetBuilder> routes = {
    userScreen: (context) => const UserView(),
    historyScreen:(context)=> const HistoryView(),
    initialRoute: (context) => const HomeView(),
  };
}