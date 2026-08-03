import 'package:agenda_wizard/providers/agendaProvider.dart';
import 'package:agenda_wizard/providers/userProvider.dart';
import 'package:agenda_wizard/routing/router.dart';
import 'package:agenda_wizard/routing/routes.dart';
import 'package:agenda_wizard/styles/theme_util.dart';
import 'package:agenda_wizard/ui/features/authentication/view_model/logout_viewmodel.dart';
import 'package:agenda_wizard/ui/features/authentication/view_model/profile_agendas_viewmodel.dart';
import 'package:agenda_wizard/ui/features/authentication/widgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final LogoutViewModel logOutViewModel;
  final ProfileViewModel profileViewModel;
  const Profile(
      {super.key,
      required this.logOutViewModel,
      required this.profileViewModel});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int agendaCount = 0;

  @override
  Widget build(BuildContext context) {
    String userName = context.watch<UserProvider>().name;
    final agendaCount =
        context.watch<AgendaProvider>().userEventPlans?.length ?? 0;

    final ThemeData theme = Theme.of(context);
    return Container(
        color: context.theme.colorScheme.surfaceContainer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Hi, $userName!",
                  style: context.theme.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text("You have $agendaCount agendas created."),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primaryFixed,
                    ),
                    onPressed: () => router.go(Routes.agendas),
                    child: Text('Agenda List',
                        style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onPrimaryFixed))),
                const SizedBox(
                  height: 30,
                ),
                Center(child: SignOut(logOutViewModel: widget.logOutViewModel))
              ],
            )
          ]),
        ));
  }
}
