import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/audience_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/concrete_decision_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/event_count_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/facilitate_breakout_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/breakout_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/generate_agenda_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/goal_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_overview.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/participant_count_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/series_event_length_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/series_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/facilitate_single_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/single_event_length_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/step_provider.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/steps/audience_step_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/steps/breakout_step_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/steps/concrete_decision_step_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/steps/event_count_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/steps/event_length_step_widget.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/steps/generate_agenda_step_widget.dart';
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
  const AgendaWizard._(
      {super.key,
      required this.viewModel,
      required this.refreshWizardCallback});
  final BuildAgendaViewmodel viewModel;
  final Function refreshWizardCallback;

  static Provider provider(
      {Key? key,
      required BuildAgendaViewmodel pViewModel,
      required Function pRefreshVizardCallback}) {
    return Provider<AgendaWizardProvider>(
      key: key,
      create: (_) => AgendaWizardProvider(pViewModel, pRefreshVizardCallback),
      dispose: (_, provider) => provider.dispose(),
      child: AgendaWizard._(
        key: key,
        viewModel: pViewModel,
        refreshWizardCallback: pRefreshVizardCallback,
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
            step: provider.goalStepProvider,
          ),
          WizardStepController(step: provider.concreteStepProvider),
          WizardStepController(
            step: provider.topicStepProvider,
          ),
          WizardStepController(step: provider.audienceStepProvider),
          WizardStepController(step: provider.participantStepProvider),
          WizardStepController(step: provider.breakoutStepProvider),
          WizardStepController(step: provider.facilitatedStepProvider),
          WizardStepController(step: provider.facilitatedBreakoutStepProvider),
          WizardStepController(step: provider.seriesStepProvider),
          WizardStepController(step: provider.eventCountStepProvider),
          WizardStepController(step: provider.eventLengthStepProvider),
          WizardStepController(step: provider.seriesEventLengthStepProvider),
          WizardStepController(step: provider.generateWizardStepProvider)
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
                listener: (context, event) async {
                  debugPrint('### ${event.runtimeType} received');
                  if (event is WizardGoEvent) {
                    int toIndex = event.toIndex;
                    StepProvider? upcomingProvider =
                        provider.stepProviderMap[Steps.values[toIndex]];

                    if (upcomingProvider == null) {
                      throw Exception("Idk weird stuff provider is null");
                    }
                    if (event.toIndex > event.fromIndex) {
                      upcomingProvider.previousStep = event.fromIndex;
                    }
                    // if (provider.stepProviderMap.keys.elementAt(toIndex) ==
                    //     Steps.generateWizardStep) {
                    //   provider.dispose();
                    // }
                  }
                },
                child: LayoutBuilder(builder: (context, constraints) {
                  return Column(children: [
                    _buildProgressIndicator(context),
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
        if (state is ConcreteDecisionProvider) {
          return ConcreteDecisionStepWidget(provider: state);
        }
        if (state is TopicStepProvider) {
          return TopicStepWidget(
            provider: state,
          );
        }
        if (state is AudienceStepProvider) {
          return AudienceStepWidget(
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
        if (state is GenerateAgendaProvider) {
          return GenerateAgendaStepWizard(
            provider: state,
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

  Widget _buildProgressIndicator(
    BuildContext context,
  ) {
    return StreamBuilder<int>(
      stream: context.wizardController.indexStream,
      initialData: context.wizardController.index,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return const SizedBox.shrink();
        }
        final index = snapshot.data!;
        int count = context.wizardController.stepCount - 1;
        assert(index <= count && index >= 0 && count > 1);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: LinearProgressIndicator(
            value: index / count,
          ),
        );
      },
    );
  }
}

class AgendaWizardProvider {
  Map<Steps, StepProvider> stepProviderMap = {};

  AgendaWizardProvider(this.viewModel, this.refreshWizardCallback) {
    stepProviderMap = {
      Steps.goalStep: GoalStepProvider(viewModel),
      Steps.concreteDecisionStep: ConcreteDecisionProvider(viewModel),
      Steps.topicStep: TopicStepProvider(viewModel),
      Steps.audienceStep: AudienceStepProvider(viewModel),
      Steps.participantStep: ParticipantCountStepProvider(viewModel),
      Steps.breakoutStep: BreakoutStepProvider(viewModel),
      Steps.facilitatedStep: FacilitateSingleProvider(viewModel),
      Steps.facilitatedBreakoutStep: FacilitateBreakoutProvider(viewModel),
      Steps.seriesStep: SeriesStepProvider(viewModel),
      Steps.eventCountStep: EventCountProvider(viewModel),
      Steps.eventLengthStep: SingleEventLengthProvider(viewModel),
      Steps.seriesEventLengthStep: SeriesEventLengthProvider(viewModel),
      Steps.generateWizardStep: GenerateAgendaProvider(
          viewModel: viewModel,
          closeShopCallback: dispose,
          refreshWizardCallback: refreshWizardCallback)
    };

    goalStepProvider = stepProviderMap[Steps.goalStep]!;
    concreteStepProvider = stepProviderMap[Steps.concreteDecisionStep]!;
    topicStepProvider = stepProviderMap[Steps.topicStep]!;
    audienceStepProvider = stepProviderMap[Steps.audienceStep]!;
    participantStepProvider = stepProviderMap[Steps.participantStep]!;
    breakoutStepProvider = stepProviderMap[Steps.breakoutStep]!;
    facilitatedStepProvider = stepProviderMap[Steps.facilitatedStep]!;
    facilitatedBreakoutStepProvider =
        stepProviderMap[Steps.facilitatedBreakoutStep]!;
    seriesStepProvider = stepProviderMap[Steps.seriesStep]!;
    eventCountStepProvider = stepProviderMap[Steps.eventCountStep]!;
    eventLengthStepProvider = stepProviderMap[Steps.eventLengthStep]!;
    seriesEventLengthStepProvider =
        stepProviderMap[Steps.seriesEventLengthStep]!;
    generateWizardStepProvider = stepProviderMap[Steps.generateWizardStep]!;
  }

  late StepProvider goalStepProvider;
  late StepProvider concreteStepProvider;
  late StepProvider topicStepProvider;
  late StepProvider audienceStepProvider;
  late StepProvider participantStepProvider;
  late StepProvider breakoutStepProvider;
  late StepProvider facilitatedStepProvider;
  late StepProvider facilitatedBreakoutStepProvider;
  late StepProvider seriesStepProvider;
  late StepProvider eventCountStepProvider;
  late StepProvider eventLengthStepProvider;
  late StepProvider seriesEventLengthStepProvider;
  late StepProvider generateWizardStepProvider;

  final BuildAgendaViewmodel viewModel;
  final Function refreshWizardCallback;

  Future<void> reportIssue() async {
    debugPrint('Finished!');
  }

  Future<void> dispose() async {
    goalStepProvider.dispose();
    concreteStepProvider.dispose();
    topicStepProvider.dispose();
    audienceStepProvider.dispose();
    participantStepProvider.dispose();
    breakoutStepProvider.dispose();
    facilitatedStepProvider.dispose();
    facilitatedBreakoutStepProvider.dispose();
    seriesStepProvider.dispose();
    eventCountStepProvider.dispose();
    eventLengthStepProvider.dispose();
    seriesEventLengthStepProvider.dispose();
    generateWizardStepProvider.dispose();
  }
}
