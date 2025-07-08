import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/finish_button.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/next_button.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/previous_button.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';


class ProgressButtons extends StatefulWidget {
  const ProgressButtons({super.key, required this.provider, this.prevEnabled});
  final FormStepProvider provider;
  final bool? prevEnabled;

  @override
  State<ProgressButtons> createState() => _ProgressButtonsState();
}

class _ProgressButtonsState extends State<ProgressButtons> {
  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Colors.redAccent,
            width: double.infinity,
            child: _errorMessage.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: $_errorMessage',
                      textAlign: TextAlign.left,
                    ),
                  )
                : null),
        _buildButtons(
            context, widget.provider, widget.prevEnabled ?? true)
      ],
    );
  }
}

Widget _buildButtons(BuildContext context, FormStepProvider provider,
    bool prevEnabled) {
  return StreamBuilder<int>(
    stream: context.wizardController.indexStream,
    initialData: context.wizardController.index,
    builder: (context, snapshot) {
      bool isFinished = false;
      if (!snapshot.hasData || snapshot.hasError) {
        return const SizedBox.shrink();
      }
      final index = snapshot.data!;
      if (context.wizardController.isFirstStep(index)) {
        prevEnabled = false;
      }
      if (provider.calculateNextStep() == 1000) {
        isFinished = true;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 10,
          ),
          prevEnabled
              ? PreviousButton(
                  returnFunc: provider.goPreviousStep,
                )
              : const SizedBox.shrink(),
          const SizedBox(width: 10),
          isFinished
              ? FinishButton(provider: provider)
              : NextButton(provider: provider),
        ],
      );
    },
  );
}
