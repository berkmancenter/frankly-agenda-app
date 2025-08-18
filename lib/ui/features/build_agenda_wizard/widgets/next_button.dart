import 'package:agenda_wizard/ui/core/widgets/main_button.dart';

import '../../../../../styles/styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.provider});
  final FormStepProvider provider;

  void goNextStep() {
    provider.goNextStep();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: provider.getNextEnabledStream(),
      initialData: provider.isNextStepEnabled(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return const SizedBox.shrink();
        }
        final enabled = snapshot.data!;
        if (enabled) {
          return MainButton(
            callBack: goNextStep,
            buttonText: "Next",
          );
        } else {
          return MainButton(
            buttonText: 'Next',
            callBack: () => {},
            isDisabled: true,
          );
        }
      },
    );
  }
}
