import 'package:agenda_wizard/providers/agendaProvider.dart';
import 'package:agenda_wizard/providers/userProvider.dart';
import 'package:agenda_wizard/ui/core/widgets/app_header.dart';
import 'package:agenda_wizard/ui/core/widgets/web_app_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';

class AppScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppScaffold({Key? key, required this.navigationShell})
      : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));

  void _goBranch(int index, BuildContext context) {
    navigationShell.goBranch(index,
        initialLocation: index == navigationShell.currentIndex);

    if (index == 2) {
      final user = context.read<UserProvider>().currentUser;
      if (user != null) {
        context.read<AgendaProvider>().loadEventPlans(user);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return DefaultTabController(
          initialIndex: navigationShell.currentIndex,
          length: 5,
          child: Builder(builder: (context) {
            final tabController = DefaultTabController.of(context);
            tabController.addListener(() {
              if (tabController.indexIsChanging) {
                _goBranch(tabController.index, context);
              }
            });
            return Scaffold(
              appBar: WebAppHeader(
                  tabCallback: _goBranch,
                  currIndex: navigationShell.currentIndex),
              body: navigationShell,
            );
          }));
    } else {
      return Scaffold(
          appBar: const AppHeader(),
          body: navigationShell,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.create_rounded), label: "Create Agenda"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.view_agenda), label: "Agenda List"),
            ],
            onTap: (int index) => _goBranch(index, context),
          ));
    }
  }
}

// int _calculateSelectedIndex(BuildContext context) {
//     final GoRouter route = GoRouter.of(context);
//     final String location = route.location();
//     if (location.startsWith('/home')) {
//       return 0;
//     }
//     if (location.startsWith('/search')) {
//       return 1;
//     }
//     if (location.startsWith('/account')) {
//       return 2;
//     }
//     return 0;
//   }
//   void onTap(int value) {
//     switch (value) {
//       case 0:
//         return context.go('/home');
//       case 1:
//         return context.go('/search');
//       case 2:
//         return context.go('/account');
//       default:
//         return context.go('/home');
//     }
//   }
// }
