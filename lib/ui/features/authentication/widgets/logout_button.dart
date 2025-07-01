import 'package:agenda_wizard/routing/routes.dart';
import 'package:agenda_wizard/ui/features/authentication/view_model/logout_viewmodel.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignOut extends StatefulWidget {
  const SignOut({super.key, required LogoutViewModel logOutViewModel})
      : _logOutViewModel = logOutViewModel;

  final LogoutViewModel _logOutViewModel;

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  Future<void> submitLogOut() async {
    final router = GoRouter.of(context);
    try {
      final result = await widget._logOutViewModel.logOut();
      switch (result) {
        case Ok<void>():
          router.go(Routes.home);
        case Error():
          router.go(Routes.error);
      }
    } catch (e) {
      router.go(Routes.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: submitLogOut,
            icon: const Icon(Icons.logout)),
        const Text('Logout')
      ],
    );
  }
}
