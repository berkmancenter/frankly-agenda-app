import 'package:agenda_wizard/models/agenda/agenda_section.dart';
import '../../../../../styles/app_styles.dart';
import '../../../../../styles/theme_util.dart';
import 'package:agenda_wizard/ui/core/widgets/divider_line.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/widgets/agenda_item.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgendaSectionWidget extends StatefulWidget {
  final AgendaSection section;
  final int sectionIndex;
  final int agendaIndex;
  final GlobalKey<FormState> formKey;
  final AgendaEditorViewmodel viewmodel;

  const AgendaSectionWidget(
      {super.key,
      required this.section,
      required this.sectionIndex,
      required this.agendaIndex,
      required this.formKey,
      required this.viewmodel});

  @override
  State<AgendaSectionWidget> createState() => _AgendaSectionWidgetState();
}

class _AgendaSectionWidgetState extends State<AgendaSectionWidget> {
  bool isEditing = false;

  final TextEditingController sectionName = TextEditingController();
  final TextEditingController sectionDescription = TextEditingController();
  final TextEditingController itemDuration = TextEditingController();

  @override
  void dispose() {
    sectionName.dispose();
    sectionDescription.dispose();
    itemDuration.dispose();
    super.dispose();
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void updateSection() {
    widget.viewmodel.updateSectionInfo(widget.agendaIndex, widget.sectionIndex,
        sectionName.text, sectionDescription.text);

    // Update agenda if we already have it saved
    if (widget.viewmodel.eventPlan.id != null) {
      widget.viewmodel.updateAgenda();
    }
    isEditing = false;
  }

  void deleteSection() {
    widget.viewmodel.deleteSection(
      widget.agendaIndex,
      widget.sectionIndex,
    );

    // Update agenda if we already have it saved
    if (widget.viewmodel.eventPlan.id != null) {
      widget.viewmodel.updateAgenda();
    }
  }

  void addItem(String title, String content) {
    widget.viewmodel
        .addItem(widget.agendaIndex, widget.sectionIndex, title, content);
  }

  @override
  Widget build(BuildContext context) {
    final agendaSectionFormKey = widget.formKey;

    sectionName.value = TextEditingValue(text: widget.section.name);
    sectionDescription.value =
        TextEditingValue(text: widget.section.description);
    itemDuration.value =
        TextEditingValue(text: widget.section.duration.minutes.toString());

    Widget sectionWidgets;
    if (isEditing) {
      sectionWidgets = Form(
          key: agendaSectionFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(sectionName.text, style: AppTextStyle.headline4),
                  IconButton(
                      onPressed: () => toggleEditing(),
                      icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FormInput(
                labelText: 'Section Name',
                fieldController: sectionName,
                isRequired: true,
              ),
              FormInput(
                labelText: "Section Description",
                fieldController: sectionDescription,
                isRequired: false,
                inputType: TextInputType.multiline,
                maxLines: null,
                minLines: 4,
              ),
              FormInput(
                labelText: 'Section Duration (in minutes)',
                fieldController: itemDuration,
                isRequired: true,
                inputType: TextInputType.number,
                width: 100,
                typeFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                      label: const Text('Save'),
                      onPressed: () => updateSection(),
                      icon: const Icon(Icons.save)),
                ],
              ),
            ],
          ));
    } else {
      sectionWidgets = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(widget.section.name, style: AppTextStyle.headline4),
              ),
              Row(
                children: [
                  DeleteIcon(
                    deleteCallback: deleteSection,
                    agendaPart: "section",
                  ),
                  IconButton(
                      onPressed: () => toggleEditing(),
                      icon: const Icon(Icons.edit)),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.timer_outlined),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("${widget.section.duration.minutes} minutes"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.section.description,
            style: context.theme.textTheme.bodyMedium,
          ),
        ],
      );
    }

    return Container(
        // backgroundColor: context.theme.colorScheme.onTertiary,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.onTertiary,
          border: Border.all(
            color: context.theme.colorScheme.onTertiary,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          sectionWidgets,
          const SizedBox(
            height: 20,
          ),
          ..._generateAgendaItems(),
          const SizedBox(
            height: 20,
          ),
          AddAgendaPart(
            addCallback: addItem,
            agendaPart: "prompt",
            titleLabel: "Prompt Title",
            contentLabel: "Prompt Content",
            durationLabel: 'How many minutes should this prompt take?',
          ),
          const DividerLine(),
        ]));
  }

  List<Widget> _generateAgendaItems() {
    List<Widget> agendaItems = [];

    for (var i = 0; i < widget.section.items.length; i++) {
      agendaItems.add(AgendaItemWidget(
        item: widget.section.items[i],
        itemIndex: i,
        formKey: GlobalKey<FormState>(),
        sectionIndex: widget.sectionIndex,
        agendaIndex: widget.agendaIndex,
        viewmodel: widget.viewmodel,
        parentDuration: widget.section.duration,
      ));
    }
    return agendaItems;
  }
}
