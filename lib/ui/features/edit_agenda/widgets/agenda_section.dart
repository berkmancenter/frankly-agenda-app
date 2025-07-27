import 'package:agenda_wizard/models/agenda/agenda_section.dart';
import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/core/themes/theme_util.dart';
import 'package:agenda_wizard/ui/core/widgets/divider_line.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/widgets/agenda_item.dart';
import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    sectionName.dispose();
    sectionDescription.dispose();
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
    isEditing = false;
  }

  void deleteSection() {
    widget.viewmodel.deleteSection(
      widget.agendaIndex,
      widget.sectionIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final agendaSectionFormKey = widget.formKey;

    sectionName.value = TextEditingValue(text: widget.section.name);
    sectionDescription.value =
        TextEditingValue(text: widget.section.description);

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
              TextButton.icon(
                  label: const Text('Save'),
                  onPressed: () => updateSection(),
                  icon: const Icon(Icons.save)),
            ],
          ));
    } else {
      sectionWidgets = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${widget.sectionIndex + 1}. ${widget.section.name}",
                  style: AppTextStyle.headline4),
              Row(
                children: [
                  IconButton(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              title: const Text(
                                  'Are you sure you want to delete this section?'),
                              children: <Widget>[
                                SimpleDialogOption(
                                  onPressed: () {
                                    deleteSection();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Yes'),
                                ),
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          }),
                      icon: const Icon(Icons.delete)),
                  IconButton(
                      onPressed: () => toggleEditing(),
                      icon: const Icon(Icons.edit)),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.section.description,
            style: AppTextStyle.body,
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
          Text(
            "Prompts:",
            style: AppTextStyle.subhead,
          ),
          const SizedBox(
            height: 10,
          ),
          ..._generateAgendaItems(),
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
      ));
    }
    return agendaItems;
  }
}
