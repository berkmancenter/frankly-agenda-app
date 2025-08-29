import 'package:agenda_wizard/ui/core/widgets/main_button.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
import 'package:flutter/material.dart';

class FinishButton extends StatelessWidget {
  const FinishButton({super.key, required this.provider});
  final FormStepProvider provider;

  @override
  Widget build(BuildContext context) {
    return MainButton(
      buttonText: 'Generate Wizard',
      callBack: provider.goNextStep,
    );
  }
}
