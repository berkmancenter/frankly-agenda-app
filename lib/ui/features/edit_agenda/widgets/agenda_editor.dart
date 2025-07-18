import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/core/themes/theme_util.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/widgets/agenda_section.dart';
import 'package:agenda_wizard/utils/helper_functions.dart';
import 'package:flutter/material.dart';

class AgendaEditor extends StatelessWidget {
  const AgendaEditor({super.key, required this.viewModel});

  final AgendaEditorViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      Text(
        viewModel.eventPlan.eventName,
        style: AppTextStyle.headline3,
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        'We\'ve got an agenda started for you. Take a look and feel free to edit it to suit your needs! When you\'re done, you can save or export it.',
        style: AppTextStyle.eyebrowSmall,
      ),
      const SizedBox(
        height: 20,
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
        height: 10,
      ),
    ]);
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
              TextButton.icon(
                  label: const Text('Save'),
                  onPressed: () => updateEvent(),
                  icon: const Icon(Icons.save)),
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
          Text("Event Name", style: AppTextStyle.bodyMedium),
          Text(
            widget.event.eventName,
            style: AppTextStyle.body,
          ),
          const SizedBox(
            height: 15,
            width: double.infinity,
          ),
          Text("Event Description", style: AppTextStyle.bodyMedium),
          Text(
            widget.event.eventDescription,
            style: AppTextStyle.body,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            viewmodel.eventPlan.isSeries == false
                ? "Agenda"
                : "Agenda ${numToString(agendaIndex + 1)}",
            style: AppTextStyle.headlineSmall),
        const SizedBox(
          height: 20,
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
              child: Column(
                  children: [..._generateAgendaSections(agendaIndex, agenda)]),
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
