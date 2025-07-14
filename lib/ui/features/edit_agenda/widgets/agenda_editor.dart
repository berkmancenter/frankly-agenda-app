import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:agenda_wizard/models/agenda/agenda_section.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/routing/router.dart';
import 'package:agenda_wizard/routing/routes.dart';
import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AgendaEditor extends StatelessWidget {
  const AgendaEditor(
      {super.key, required this.viewModel, required this.eventPlan});

  final AgendaEditorViewmodel viewModel;
  final EventPlan eventPlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => router.go(Routes.agendas),
                    icon: const Icon(Icons.view_agenda)),
                const Text("Agenda Editor"),
                const SizedBox(
                  width: 50,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  eventPlan.eventName,
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
                EditAgendaForm(
                  viewModel: viewModel,
                  event: eventPlan,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EditAgendaForm extends StatefulWidget {
  final AgendaEditorViewmodel viewModel;
  final EventPlan event;
  const EditAgendaForm(
      {super.key, required this.viewModel, required this.event});

  @override
  State<EditAgendaForm> createState() => _EditAgendaFormState();
}

class _EditAgendaFormState extends State<EditAgendaForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _name.value = TextEditingValue(text: widget.event.eventName);
    _description.value = TextEditingValue(text: widget.event.eventDescription);
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
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
            _generateAgendas(widget.event),
          ],
        ));
  }
}

Widget _generateAgendas(EventPlan event) {
  Widget? agendaSectionsColumn;
  if (event.isSeries) {
    for (var i = 0; i < event.agendas.length; i++) {
      List<Widget> agendaSections =
          _generateAgendaSections(i, event.agendas[i]);
      int agendaCount = i + 1;
      agendaSectionsColumn = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            "Agenda ${numToString(agendaCount)}",
            style: AppTextStyle.headline4,
            textAlign: TextAlign.center,
          ),
          ...agendaSections
        ],
      );
    }
  } else {
    if (event.agendas.isEmpty) {
      return const Text("No agendas found.");
    }
    List<Widget> agendaSections =
        _generateAgendaSections(null, event.agendas[0]);
    agendaSectionsColumn = Column(
      children: [...agendaSections],
    );
  }
  return agendaSectionsColumn ?? const Text("No agendas.");
}

List<Widget> _generateAgendaSections(int? agendaIndex, Agenda agenda) {
  List<Widget> agendaSections = [];

  for (var i = 0; i < agenda.sections.length; i++) {
    final TextEditingController sectionName =
        TextEditingController(text: agenda.sections[i].name);
    final TextEditingController sectionDescription =
        TextEditingController(text: agenda.sections[i].description);
    agendaSections.add(
      FormInput(
        labelText: 'Section Title',
        fieldController: sectionName,
        isRequired: true,
      ),
    );
    agendaSections.add(
      FormInput(
        labelText: "Section Description",
        fieldController: sectionDescription,
        isRequired: false,
        inputType: TextInputType.multiline,
        maxLines: null,
        minLines: 4,
      ),
    );
    agendaSections.add(const SizedBox(height: 20));
    agendaSections.add(Text(
      "${agenda.sections[i].name} Items",
      style: AppTextStyle.bodyMedium,
      textAlign: TextAlign.left,
    ));
    List<Widget> items = _generateAgendaItems(agenda.sections[i]);
    for (Widget item in items) {
      agendaSections.add(item);
    }
    agendaSections.add(const SizedBox(height: 20));
  }

  return agendaSections;
}

List<Widget> _generateAgendaItems(AgendaSection agendaSection) {
  List<Widget> agendaItems = [];

  for (var i = 0; i < agendaSection.items.length; i++) {
    // final TextEditingController itemTitle =
    //     TextEditingController(text: agendaSection.items[i].title);
    // agendaItems.add(
    //   FormInput(
    //     labelText: '',
    //     fieldController: itemTitle,
    //     isRequired: true,
    //   ),
    // );
    for (var j = 0; j < agendaSection.items[i].content.length; j++) {
      final TextEditingController itemContent =
          TextEditingController(text: agendaSection.items[i].content[j]);
      agendaItems.add(FormInput(
        labelText: "Item Prompt",
        fieldController: itemContent,
        isRequired: false,
        inputType: TextInputType.multiline,
        maxLines: null,
        minLines: 4,
      ));
    }
  }

  return agendaItems;
}
