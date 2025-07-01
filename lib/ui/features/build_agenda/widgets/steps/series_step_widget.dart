import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/series_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

class SeriesStepWidget extends StatelessWidget {
  const SeriesStepWidget({super.key, required this.provider});
  final SeriesStepProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: [
        const SizedBox(
          height: 40,
        ),
        Text(
          'Will this event be part of a series, or is it a standalone?',
          style: AppTextStyle.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        StreamBuilder<IsSeries>(
            stream: provider.getSeriesRadioStream(),
            initialData: provider.getSeriesRadioValue(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  ListTile(
                      title: const Text("Series"),
                      leading: Radio<IsSeries?>(
                        value: IsSeries.series,
                        groupValue: snapshot.data,
                        onChanged: (newValue) => provider
                            .toggleSeriesStatus(newValue ?? IsSeries.series),
                      )),
                  ListTile(
                      title: const Text("Standalone"),
                      leading: Radio<IsSeries?>(
                        value: IsSeries.standalone,
                        groupValue: snapshot.data,
                        onChanged: (newValue) => provider
                            .toggleSeriesStatus(newValue ?? IsSeries.standalone),
                      )),
                ],
              );
            }),
            _buildButtons(context, provider)
      ]),
    );
  }
}


Widget _buildButtons(BuildContext context, StepProvider provider) {
  return StreamBuilder<int>(
    stream: context.wizardController.indexStream,
    initialData: context.wizardController.index,
    builder: (context, snapshot) {
      bool isFinished = false;
      bool prevEnabled = true;
      if (!snapshot.hasData || snapshot.hasError) {
        return const SizedBox.shrink();
      }
      final index = snapshot.data!;
      if (context.wizardController.isFirstStep(index)) {
        prevEnabled = false;
      }
      if (context.wizardController.isLastStep(index)) {
        isFinished = true;
      }
      return ProgressButtons(
          provider: provider, isFinished: isFinished, prevEnabled: prevEnabled);
    },
  );
}
