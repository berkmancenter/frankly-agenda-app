import 'package:agenda_wizard/routing/routes.dart';
import 'package:flutter/material.dart';

class BuildAgendaNavigator extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print("PUSHING ${route.settings.name}");

    if (route.settings.name == Routes.buildAgenda) {
      print("GONNA BUILD AN AGENDA");
    }
  }
}
