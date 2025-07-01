import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/goal_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/progress_buttons.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_overview.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/hosted_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/series_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/steps/goal_step_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/topic_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/steps/hosted_step_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/steps/series_step_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda/widgets/steps/topic_step_widget.dart';
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
          WizardStepController(
              step: provider.stepFourProvider, isNextEnabled: false)
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
                  if (event is WizardForcedGoBackToEvent) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Step ${event.toIndex + 2} got disabled so the wizard is moving back to step ${event.toIndex + 1}.',
                      ),
                      dismissDirection: DismissDirection.horizontal,
                    ));
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
      if (state is HostedStepProvider) {
        return HostedStepWidget(provider: state);
      }
      if (state is SeriesStepProvider) {
        return SeriesStepWidget(provider: state);
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
      : stepOneProvider = GoalStepProvider(),
        stepTwoProvider = TopicStepProvider(),
        stepThreeProvider = HostedStepProvider(),
        stepFourProvider = SeriesStepProvider();

  final GoalStepProvider stepOneProvider;
  final TopicStepProvider stepTwoProvider;
  final HostedStepProvider stepThreeProvider;
  final SeriesStepProvider stepFourProvider;

  Future<void> reportIssue() async {
    debugPrint('Finished!');
  }

  Future<void> dispose() async {
    stepOneProvider.dispose();
    stepTwoProvider.dispose();
    stepThreeProvider.dispose();
    stepFourProvider.dispose();
  }
}
