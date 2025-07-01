import 'package:agenda_wizard/ui/features/build_agenda/widgets/finish_button.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/next_button.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/previous_button.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

class ProgressButtons extends StatelessWidget {
  const ProgressButtons(
      {super.key,
      required this.provider,
      required this.isFinished,
      required this.prevEnabled});
  final StepProvider provider;
  final bool isFinished;
  final bool prevEnabled;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 10,),
          prevEnabled ? const PreviousButton() : const SizedBox.shrink(),
          const SizedBox(width: 10),
          isFinished ? const FinishButton() : NextButton(provider: provider),
        ],
      );
  }
}
