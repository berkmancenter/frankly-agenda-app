import 'package:agenda_wizard/data/repositories/auth/auth_repository.dart';
import 'package:agenda_wizard/routing/routes.dart';
import 'package:agenda_wizard/ui/core/themes/theme_util.dart';
import 'package:agenda_wizard/ui/features/authentication/view_model/logout_viewmodel.dart';
import 'package:agenda_wizard/ui/features/authentication/widgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? userName;
  const AppHeader({
    super.key,
    this.userName,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Agenda Builder'),
      shape: Border(
        bottom: BorderSide(
          color:
              context.theme.colorScheme.onPrimaryContainer, // Customize color
          width: 1.0, // Customize thickness
        ),
      ),
      backgroundColor: context.theme.colorScheme.onTertiary,
      elevation: 4,
      actions: [
        Consumer<AuthRepository>(
            builder: (context, authState, _) => Row(
                  children: [
                    if (authState.loggedIn) ...[
                      SignOut(
                        logOutViewModel: LogoutViewModel(
                          authRepository: context.read(),
                        ),
                      ),
                    ] else ...[
                      TextButton.icon(
                          label: const Text('Login'),
                          onPressed: () => context.push(Routes.login),
                          icon: const Icon(Icons.login)),
                    ]
                  ],
                ))
      ],
    );
  }
}
