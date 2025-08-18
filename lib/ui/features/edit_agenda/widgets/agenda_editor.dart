import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/models/agenda/warning.dart';
import 'package:agenda_wizard/routing/router.dart';
import 'package:agenda_wizard/routing/routes.dart';
import '../../../../../styles/app_styles.dart';
import '../../../../../styles/theme_util.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/widgets/agenda_section.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/widgets/shared_widgets.dart';
import 'package:agenda_wizard/utils/helper_functions.dart';
import 'package:flutter/material.dart';

class AgendaEditor extends StatelessWidget {
  const AgendaEditor({super.key, required this.viewModel});

  final AgendaEditorViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const SizedBox(
        height: 10,
      ),
      Text(
        viewModel.eventPlan.eventName,
        style: context.theme.textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        'We\'ve got an agenda started for you. Take a look and feel free to edit it to suit your needs! When you\'re done, you can save or export it.',
        style: AppTextStyle.eyebrowSmall,
      ),
      _generateWarningWidget(theme),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              label: const Text('Update Event'),
              onPressed: () => {
                    router.go(Routes.buildAgenda,
                        extra: viewModel.buildAgendaRepository
                            .getLastAgendaBuild())
                  },
              icon: const Icon(Icons.update)),
          if (viewModel.editState == EditState.hasUpdated)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                    label: const Text('Reset Event'),
                    onPressed: () => {viewModel.resetEventPlan()},
                    icon: const Icon(Icons.restore)),
              ],
            ),
          if (viewModel.editState == EditState.hasReverted)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                    label: const Text('Undo Reset'),
                    onPressed: () => {viewModel.undoReset()},
                    icon: const Icon(Icons.undo)),
              ],
            ),
        ],
      ),
      EventDetails(
        viewModel: viewModel,
        event: viewModel.eventPlan,
      ),
      const SizedBox(
        height: 20,
      ),
      ..._generateAgendas(viewModel.eventPlan, viewModel),
      const SizedBox(
        height: 20,
      ),
      TextButton.icon(
          label: const Text('Add Agenda'),
          onPressed: () => {viewModel.addAgenda()},
          icon: const Icon(Icons.save)),
    ]);
  }

  Widget _generateWarningWidget(ThemeData theme) {
    if (viewModel.eventPlan.warnings != null &&
        viewModel.eventPlan.warnings!.isNotEmpty) {
      List<Widget> warningWidgets = [];
      for (Warning warning in viewModel.eventPlan.warnings!) {
        warningWidgets.add(Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(4),
                ),
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Warning: ${warning.message}",
                          textAlign: TextAlign.left,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ))),
          ],
        ));
      }
      return Column(
        children: [...warningWidgets],
      );
    } else {
      return const SizedBox(
        height: 20,
      );
    }
  }
}

class EventDetails extends StatefulWidget {
  final AgendaEditorViewmodel viewModel;
  final EventPlan event;
  const EventDetails({super.key, required this.viewModel, required this.event});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final _eventDetailFormKey = GlobalKey<FormState>();

  bool isEditing = false;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void updateEvent() {
    widget.viewModel.updateEventInfo(_name.text, _description.text);
    isEditing = false;
  }

  @override
  Widget build(BuildContext context) {
    _name.value = TextEditingValue(text: widget.event.eventName);
    _description.value = TextEditingValue(text: widget.event.eventDescription);
    Widget detailsWidget;
    if (isEditing) {
      detailsWidget = Form(
          key: _eventDetailFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormInput(
                labelText: 'Event Name',
                fieldController: _name,
                isRequired: true,
              ),
              FormInput(
                labelText: "Event Description",
                fieldController: _description,
                isRequired: false,
                inputType: TextInputType.multiline,
                maxLines: null,
                minLines: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                      label: const Text('Save'),
                      onPressed: () => updateEvent(),
                      icon: const Icon(Icons.save)),
                ],
              ),
            ],
          ));
    } else {
      detailsWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
            width: double.infinity,
          ),
          Text("Event Name", style: context.theme.textTheme.bodyMedium),
          Text(
            widget.event.eventName,
            style: context.theme.textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 15,
            width: double.infinity,
          ),
          Text("Event Description", style: context.theme.textTheme.bodyMedium),
          Text(
            widget.event.eventDescription,
            style: context.theme.textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 5,
            width: double.infinity,
          ),
        ],
      );
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Event Details", style: AppTextStyle.headlineSmall),
            IconButton(
                onPressed: () => toggleEditing(),
                icon: isEditing
                    ? const Icon(Icons.close)
                    : const Icon(Icons.edit)),
          ],
        ),
        Container(
            // backgroundColor: context.theme.colorScheme.onTertiary,
            decoration: BoxDecoration(
              color: context.theme.colorScheme.onTertiary,
              border: Border.all(
                color: context.theme.colorScheme.onTertiary,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: detailsWidget,
            )),
      ],
    );
  }
}

List<Widget> _generateAgendas(
    EventPlan event, AgendaEditorViewmodel viewmodel) {
  List<Widget> agendas = [];

  if (event.isSeries) {
    for (var i = 0; i < event.agendas.length; i++) {
      agendas.add(AgendaWidget(
        agenda: event.agendas[i],
        agendaIndex: i,
        viewmodel: viewmodel,
      ));
      agendas.add(const SizedBox(
        height: 30,
      ));
    }
  } else {
    if (event.agendas.isEmpty) {
      return agendas;
    }
    agendas.add(AgendaWidget(
      agenda: event.agendas[0],
      agendaIndex: 0,
      viewmodel: viewmodel,
    ));
  }
  return agendas;
}

class AgendaWidget extends StatelessWidget {
  final Agenda agenda;

  final int agendaIndex;

  final AgendaEditorViewmodel viewmodel;

  const AgendaWidget(
      {super.key,
      required this.agenda,
      required this.viewmodel,
      required this.agendaIndex});

  void deleteAgenda() {
    viewmodel.deleteAgenda(agendaIndex);
  }

  void addSection(String title, String description, int minutes) {
    viewmodel.addSection(agendaIndex, title, description, minutes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
              viewmodel.eventPlan.isSeries == false
                  ? "Agenda"
                  : "Agenda ${numToString(agendaIndex + 1)}",
              style: AppTextStyle.headlineSmall),
          DeleteIcon(
            deleteCallback: deleteAgenda,
            agendaPart: 'agenda',
          ),
        ]),
        const SizedBox(
          height: 5,
        ),
        Container(
            decoration: BoxDecoration(
              color: context.theme.colorScheme.onTertiary,
              border: Border.all(
                color: context.theme.colorScheme.onTertiary,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                ..._generateAgendaSections(agendaIndex, agenda),
                AddAgendaPart(
                  addCallback: addSection,
                  agendaPart: "section",
                  titleLabel: "Section Name",
                  contentLabel: "Section Description",
                  durationLabel: 'How many minutes should this section be?',
                )
              ]),
            )),
      ],
    );
  }

  List<Widget> _generateAgendaSections(int agendaIndex, Agenda agenda) {
    List<Widget> agendaSections = [];
    for (var i = 0; i < agenda.sections.length; i++) {
      agendaSections.add(AgendaSectionWidget(
        section: agenda.sections[i],
        sectionIndex: i,
        agendaIndex: agendaIndex,
        formKey: GlobalKey<FormState>(),
        viewmodel: viewmodel,
      ));
    }

    return agendaSections;
  }
}
