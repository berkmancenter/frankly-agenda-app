import 'package:agenda_wizard/ui/features/authentication/view_model/logout_viewmodel.dart';
import 'package:agenda_wizard/ui/features/authentication/widgets/logout_button.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final LogoutViewModel _logOutViewModel;
  const Profile({super.key, required LogoutViewModel logOutViewModel})
      : _logOutViewModel = logOutViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [const Text('Hi!'), SignOut(logOutViewModel: _logOutViewModel)],
    );
  }
}
