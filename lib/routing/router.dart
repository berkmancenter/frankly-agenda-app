import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:agenda_wizard/ui/core/widgets/app_scaffold.dart';
import 'package:agenda_wizard/routing/routes.dart';
import 'package:agenda_wizard/ui/features/authentication/view_model/auth_viewmodel.dart';
import 'package:agenda_wizard/ui/features/authentication/widgets/login_screen.dart';
import 'package:agenda_wizard/ui/features/authentication/widgets/signup_screen.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/build_agenda_screen.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/widgets/agenda_editor.dart';
import 'package:agenda_wizard/ui/features/home/view_model/home_viewmodel.dart';
import 'package:agenda_wizard/ui/features/home/widgets/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (context, state) {
                  final viewModel = HomeViewmodel(
                    userRepository: context.read(),
                    agendaRepository: context.read(),
                  );
                  return HomeScreen(viewModel: viewModel);
                },
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.buildAgenda,
                builder: (context, state) {
                  final buildAgendaViewModel = BuildAgendaViewmodel(
                    buildAgendaRepository: context.read(),
                  );
                  return BuildAgendaScreen(viewModel: buildAgendaViewModel);
                },
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.agendas,
                builder: (context, state) {
                  return const Placeholder(child: Text('Hi i\'m your agendas'));
                },
                redirect: (context, state) {
                  final user = FirebaseAuth.instance.currentUser;
                  return user == null ? Routes.login : null;
                },
              ),
              GoRoute(
                path: Routes.editAgenda,
                builder: (context, state) {
                  final agendaEditorViewmodel = AgendaEditorViewmodel(
                    agendaRepository: context.read(),
                  );
                  List<Agenda> agendas = state.extra as List<Agenda>;
                  return AgendaEditor(
                    viewModel: agendaEditorViewmodel,
                    agendas: agendas,
                  );
                },
              )
            ],
          ),
        ]),
    GoRoute(
        path: Routes.login,
        builder: (context, state) {
          final authViewModel = AuthViewModel(
            authRepository: context.read(),
          );
          return LoginScreen(
            authViewModel: authViewModel,
          );
        }),
    GoRoute(
        path: Routes.signup,
        builder: (context, state) {
          final authViewModel = AuthViewModel(
            authRepository: context.read(),
          );
          return SignupScreen(
            authViewModel: authViewModel,
          );
        }),
    GoRoute(
      path: Routes.profile,
      builder: (context, state) {
        return const Placeholder(child: Text('Hi i\'m your profile'));
      },
      redirect: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        return user == null ? Routes.login : null;
      },
    ),
    GoRoute(
      path: Routes.error,
      builder: (context, state) {
        return const Placeholder(child: Text('Hi i\'m a big error'));
      },
    )
  ],
);
