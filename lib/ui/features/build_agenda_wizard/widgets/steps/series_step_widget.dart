import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/series_step_provider.dart';
import 'package:agenda_wizard/utils/step_enums.dart';
import 'package:flutter/material.dart';

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
        StreamBuilder<IsSeries?>(
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
                            .toggleSeriesStatus(newValue),
                      )),
                  ListTile(
                      title: const Text("Standalone"),
                      leading: Radio<IsSeries?>(
                        value: IsSeries.standalone,
                        groupValue: snapshot.data,
                        onChanged: (newValue) => provider
                            .toggleSeriesStatus(newValue),
                      )),
                ],
              );
            }),
            ProgressButtons(provider: provider),
      ]),
    );
  }
}
