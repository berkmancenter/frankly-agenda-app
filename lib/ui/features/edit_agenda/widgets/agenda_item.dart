import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/utils/helper_functions.dart';
import 'package:flutter/material.dart';

class AgendaItemWidget extends StatefulWidget {
  final AgendaItem item;
  final int itemIndex;
  final int sectionIndex;
  final int agendaIndex;
  final GlobalKey<FormState> formKey;
  final AgendaEditorViewmodel viewmodel;

  const AgendaItemWidget(
      {super.key,
      required this.item,
      required this.itemIndex,
      required this.sectionIndex,
      required this.agendaIndex,
      required this.formKey,
      required this.viewmodel});

  @override
  State<AgendaItemWidget> createState() => _AgendaItemWidgetState();
}

class _AgendaItemWidgetState extends State<AgendaItemWidget> {
  bool isEditing = false;

  final TextEditingController itemTitle = TextEditingController();

  List<TextEditingController> contentControllerList = [];

  final TextEditingController itemDescription = TextEditingController();

  @override
  void dispose() {
    itemTitle.dispose();
    itemDescription.dispose();

    for (var controller in contentControllerList) {
      controller.dispose();
    }

    super.dispose();
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void updateItem() {
    List<String> contentControllerStrings = [];
    for (TextEditingController controller in contentControllerList) {
      contentControllerStrings.add(controller.text);
    }
    widget.viewmodel.updateItem(widget.agendaIndex, widget.sectionIndex,
        widget.itemIndex, itemTitle.text, contentControllerStrings);

    isEditing = false;
  }

  @override
  Widget build(BuildContext context) {
    final agendaSectionFormKey = widget.formKey;

    itemTitle.value = TextEditingValue(text: widget.item.title);

    contentControllerList = [];
    for (String contentString in widget.item.content) {
      contentControllerList.add(TextEditingController(text: contentString));
    }

    Widget itemWidget;

    List<Widget> generateContentItems() {
      List<Widget> contentStrings = [];
      for (String item in widget.item.content) {
        contentStrings.add(Text(
          item,
          style: AppTextStyle.body,
        ));
        contentStrings.add(
          const SizedBox(
            height: 10,
          ),
        );
      }
      return contentStrings;
    }

    List<Widget> generateFormContentItems() {
      List<Widget> contentControllers = [];
      for (int i = 0; i < widget.item.content.length; i++) {
        contentControllers.add(
          FormInput(
            labelText: "Item Content ${numToString(i + 1)}",
            fieldController: contentControllerList[i],
            isRequired: false,
            inputType: TextInputType.multiline,
            maxLines: null,
            minLines: 4,
          ),
        );
      }

      return contentControllers;
    }

    if (isEditing) {
      itemWidget = Form(
          key: agendaSectionFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text("${widget.itemIndex + 1}. ${widget.item.title}",
                        style: AppTextStyle.bodyMedium),
                  ),
                  IconButton(
                      onPressed: () => toggleEditing(),
                      icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FormInput(
                labelText: 'Item Title',
                fieldController: itemTitle,
                isRequired: true,
              ),
              ...generateFormContentItems(),
              TextButton.icon(
                  label: const Text('Save'),
                  onPressed: () => updateItem(),
                  icon: const Icon(Icons.save)),
            ],
          ));
    } else {
      itemWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text("${widget.itemIndex + 1}. ${widget.item.title}",
                    style: AppTextStyle.bodyMedium),
              ),
              IconButton(
                  onPressed: () => toggleEditing(),
                  icon: const Icon(Icons.edit)),
            ],
          ),
          ...generateContentItems(),
        ],
      );
    }

    return itemWidget;
  }
}
