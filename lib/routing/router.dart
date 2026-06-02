import 'package:agenda_wizard/data/repositories/build_agenda/build_agenda_repository.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/models/builder/agenda_builder.dart';
import 'package:agenda_wizard/ui/core/widgets/app_scaffold.dart';
import 'package:agenda_wizard/routing/routes.dart';
import 'package:agenda_wizard/ui/features/authentication/view_model/auth_viewmodel.dart';
import 'package:agenda_wizard/ui/features/authentication/view_model/logout_viewmodel.dart';
import 'package:agenda_wizard/ui/features/authentication/view_model/profile_agendas_viewmodel.dart';
import 'package:agenda_wizard/ui/features/authentication/widgets/login_screen.dart';
import 'package:agenda_wizard/ui/features/authentication/widgets/profile.dart';
import 'package:agenda_wizard/ui/features/authentication/widgets/signup_screen.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/build_agenda_screen.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/widgets/agenda_editor_screen.dart';
import 'package:agenda_wizard/ui/features/home/view_model/home_viewmodel.dart';
import 'package:agenda_wizard/ui/features/home/widgets/home_screen.dart';
import 'package:agenda_wizard/ui/features/list_agendas/view_model/list_agendas_viewmodel.dart';
import 'package:agenda_wizard/ui/features/list_agendas/widgets/list_agendas_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                    buildAgendaRepository: context.read(),
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
                  AgendaBuilder? agendaBuilder = state.extra as AgendaBuilder?;
                  final buildAgendaViewModel = BuildAgendaViewmodel(
                      buildAgendaRepository: context.read(),
                      agendaBuilder: agendaBuilder,
                      agendaRepository: context.read(),
                      userRepository: context.read());
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
                    final listAgendasViewModel = ListAgendasViewModel(
                        buildAgendaRepository: context.read(),
                        agendaRepository: context.read());
                    return ListAgendasScreen(
                      viewmodel: listAgendasViewModel,
                    );
                  },
                  // redirect: (context, state) {
                  //   final user = FirebaseAuth.instance.currentUser;
                  //   return user == null ? Routes.login : null;
                  // },
                  routes: [
                    GoRoute(
                      path: 'edit',
                      builder: (context, state) {
                        EventPlan? eventPlan = state.extra as EventPlan?;
                        BuildAgendaRepository buildAgendaRepository =
                            context.read();
                        final agendaEditorViewmodel = AgendaEditorViewmodel(
                            agendaRepository: context.read(),
                            buildAgendaRepository: buildAgendaRepository,
                            userRepository: context.read(),
                            optionalEventPlan: eventPlan);
                        return AgendaEditorScreen(
                            viewModel: agendaEditorViewmodel);
                      },
                    )
                  ]),
            ],
          ),
          StatefulShellBranch(
            routes: [
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
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                builder: (context, state) {
                  final logoutViewModel = LogoutViewModel(
                    authRepository: context.read(),
                  );
                  final profileViewModel =
                      ProfileViewModel(agendaRepository: context.read());
                  return Profile(
                    logOutViewModel: logoutViewModel,
                    profileViewModel: profileViewModel,
                  );
                },
                redirect: (context, state) {
                  final user = FirebaseAuth.instance.currentUser;
                  return user == null ? Routes.login : null;
                },
              ),
            ],
          ),
        ]),
    // GoRoute(
    //     path: Routes.login,
    //     builder: (context, state) {
    //       final authViewModel = AuthViewModel(
    //         authRepository: context.read(),
    //       );
    //       return LoginScreen(
    //         authViewModel: authViewModel,
    //       );
    //     }),
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
    // GoRoute(
    //   path: Routes.profile,
    //   builder: (context, state) {
    //     return const Text('Hi i\'m your profile');
    //   },
    //   redirect: (context, state) {
    //     final user = FirebaseAuth.instance.currentUser;
    //     return user == null ? Routes.login : null;
    //   },
    // ),
    GoRoute(
      path: Routes.error,
      builder: (context, state) {
        return const Placeholder(child: Text('Hi i\'m a big error'));
      },
    )
  ],
);
