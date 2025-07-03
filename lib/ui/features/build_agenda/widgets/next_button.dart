import 'package:agenda_wizard/ui/core/themes/styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.provider});
  final StepProvider provider;

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
          return ElevatedButton(
            onPressed: () => provider.goNextStep(),
            child: const Text("Next"),
          );
        }
        return ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: context.theme.colorScheme.primaryFixedDim,
          ),
          child: const Text("Next"),
        );
      },
    );
  }
}
