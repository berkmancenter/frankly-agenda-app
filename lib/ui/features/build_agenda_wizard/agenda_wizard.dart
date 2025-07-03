import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/event_count_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/facilitate_breakout_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/breakout_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/goal_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_overview.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/participant_count_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/series_event_length_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/series_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/facilitate_single_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/single_event_length_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/steps/breakout_step_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/steps/event_count_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/steps/event_length_step_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/steps/goal_step_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/topic_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/steps/facilitate_step_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/steps/participant_count_step_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/steps/series_step_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/steps/topic_step_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:provider/provider.dart';

class AgendaWizard extends StatelessWidget {
  const AgendaWizard._({Key? key}) : super(key: key);

  static Provider provider({Key? key}) {
    return Provider<AgendaWizardProvider>(
      create: (_) => AgendaWizardProvider(),
      dispose: (_, provider) => provider.dispose(),
      child: AgendaWizard._(
        key: key,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AgendaWizardProvider>(
      context,
    );

    return DefaultWizardController(
        stepControllers: [
          WizardStepController(
            step: provider.stepOneProvider,
          ),
          WizardStepController(
            step: provider.stepTwoProvider,
          ),
          WizardStepController(step: provider.stepThreeProvider),
          WizardStepController(step: provider.stepFourProvider),
          WizardStepController(step: provider.stepFiveProvider),
          WizardStepController(step: provider.stepSixProvider),
          WizardStepController(step: provider.stepSevenProvider),
          WizardStepController(step: provider.stepEightProvider),
          WizardStepController(step: provider.stepNineProvider),
          WizardStepController(step: provider.stepTenProvider),
        ],
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: StreamBuilder<int>(
                  stream: context.wizardController.indexStream,
                  initialData: context.wizardController.index,
                  builder: (context, snapshot) {
                    return Text("Creating Agenda",
                        style: AppTextStyle.headline4);
                  },
                ),
              ),
              body: WizardEventListener(
                listener: (context, event) {
                  debugPrint('### ${event.runtimeType} received');
                  if (event is WizardGoEvent) {
                    int toIndex = event.toIndex;
                    StepProvider? upcomingProvider =
                        stepProviderMap[Steps.values[toIndex]];
                    if (upcomingProvider == null) {
                      throw Exception("Idk weird stuff provider is null");
                    }
                    if (event.toIndex > event.fromIndex) {
                      upcomingProvider.previousStep = event.fromIndex;
                    }
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   content: Text(
                    //     'Storing ${event.toIndex} in the prev button.',
                    //   ),
                    //   dismissDirection: DismissDirection.horizontal,
                    // ));
                  }
                },
                child: LayoutBuilder(builder: (context, constraints) {
                  return Column(children: [
                    const Text("I'm a progress bar maybe"),
                    Expanded(
                      child: _buildWizard(
                        context,
                        provider: provider,
                        constraints: constraints,
                      ),
                    ),
                  ]);
                }),
              ),
            );
          },
        ));
  }
}

Widget _buildWizard(
  BuildContext context, {
  required AgendaWizardProvider provider,
  required BoxConstraints constraints,
}) {
  final wizard = Wizard(
    stepBuilder: (context, state) {
      if (state is GoalStepProvider) {
        return GoalStepWidget(
          provider: state,
        );
      }
      if (state is TopicStepProvider) {
        return TopicStepWidget(
          provider: state,
        );
      }
      if (state is ParticipantCountStepProvider) {
        return ParticipantCountWidget(
          provider: state,
        );
      }
      if (state is BreakoutStepProvider) {
        return BreakoutStepWidget(
          provider: state,
        );
      }
      if (state is FacilitateBreakoutProvider) {
        return FacilitatedStepWidget(provider: state, hasBreakouts: true);
      }
      if (state is FacilitateSingleProvider) {
        return FacilitatedStepWidget(provider: state, hasBreakouts: false);
      }
      if (state is SeriesStepProvider) {
        return SeriesStepWidget(provider: state);
      }
      if (state is EventCountProvider) {
        return EventCountWidget(provider: state);
      }
      if (state is SingleEventLengthProvider) {
        return EventLengthWidget(
          provider: state,
          isSeries: false,
        );
      }
      if (state is SeriesEventLengthProvider) {
        return EventLengthWidget(
          provider: state,
          isSeries: true,
        );
      }
      return Container();
    },
  );
  final narrow = constraints.maxWidth <= 500;
  if (narrow) {
    return Row(children: [
      Expanded(
        child: wizard,
      ),
    ]);
  }
  return Row(
    children: [
      const SizedBox(
        width: 200,
        child: StepOverview(),
      ),
      Expanded(
        child: wizard,
      ),
    ],
  );
}

class AgendaWizardProvider {
  AgendaWizardProvider()
      : stepOneProvider = stepProviderMap[Steps.goalStep]!,
        stepTwoProvider = stepProviderMap[Steps.topicStep]!,
        stepThreeProvider = stepProviderMap[Steps.participantStep]!,
        stepFourProvider = stepProviderMap[Steps.breakoutStep]!,
        stepFiveProvider = stepProviderMap[Steps.facilitatedStep]!,
        stepSixProvider = stepProviderMap[Steps.facilitatedBreakoutStep]!,
        stepSevenProvider = stepProviderMap[Steps.seriesStep]!,
        stepEightProvider = stepProviderMap[Steps.eventCountStep]!,
        stepNineProvider = stepProviderMap[Steps.eventLengthStep]!,
        stepTenProvider = stepProviderMap[Steps.seriesEventLengthStep]!;

  final StepProvider stepOneProvider;
  final StepProvider stepTwoProvider;
  final StepProvider stepThreeProvider;
  final StepProvider stepFourProvider;
  final StepProvider stepFiveProvider;
  final StepProvider stepSixProvider;
  final StepProvider stepSevenProvider;
  final StepProvider stepEightProvider;
  final StepProvider stepNineProvider;
  final StepProvider stepTenProvider;

  Future<void> reportIssue() async {
    debugPrint('Finished!');
  }

  Future<void> dispose() async {
    stepOneProvider.dispose();
    stepTwoProvider.dispose();
    stepThreeProvider.dispose();
    stepFourProvider.dispose();
    stepFiveProvider.dispose();
    stepSixProvider.dispose();
    stepSevenProvider.dispose();
    stepEightProvider.dispose();
    stepNineProvider.dispose();
    stepTenProvider.dispose();
  }
}
