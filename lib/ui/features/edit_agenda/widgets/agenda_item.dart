import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:agenda_wizard/models/agenda/custom_duration.dart';
import '../../../../../styles/theme_util.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/widgets/shared_widgets.dart';
import 'package:agenda_wizard/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgendaItemWidget extends StatefulWidget {
  final AgendaItem item;
  final int itemIndex;
  final int sectionIndex;
  final int agendaIndex;
  final GlobalKey<FormState> formKey;
  final AgendaEditorViewmodel viewmodel;
  final CustomDuration parentDuration;

  const AgendaItemWidget({
    super.key,
    required this.item,
    required this.itemIndex,
    required this.sectionIndex,
    required this.agendaIndex,
    required this.formKey,
    required this.viewmodel,
    required this.parentDuration,
  });

  @override
  State<AgendaItemWidget> createState() => _AgendaItemWidgetState();
}

class _AgendaItemWidgetState extends State<AgendaItemWidget> {
  bool isEditing = false;
  bool llmInfoOpen = false;

  final TextEditingController itemTitle = TextEditingController();
  final TextEditingController itemDuration = TextEditingController();

  List<TextEditingController> contentControllerList = [];

  final TextEditingController itemDescription = TextEditingController();

  @override
  void dispose() {
    itemTitle.dispose();
    itemDuration.dispose();
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

  void toggleLlmInfoOpen() {
    setState(() {
      llmInfoOpen = !llmInfoOpen;
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

  void deleteItem() {
    widget.viewmodel
        .deleteItem(widget.agendaIndex, widget.sectionIndex, widget.itemIndex);
  }

  @override
  Widget build(BuildContext context) {
    final agendaSectionFormKey = widget.formKey;

    final isTopicBackground = widget.item.title == "Topic Background";

    itemTitle.value = TextEditingValue(text: widget.item.title);
    if (widget.item.duration != null) {
      itemDuration.value =
          TextEditingValue(text: widget.item.duration!.minutes.toString());
    }

    contentControllerList = [];
    for (String contentString in widget.item.content) {
      contentControllerList.add(TextEditingController(text: contentString));
    }

    Widget itemWidget;

    List<Widget> generateContentItems() {
      List<Widget> contentStrings = [];
      for (int i = 0; i < widget.item.content.length; i++) {
        String itemContent = isTopicBackground
            ? ("${i + 1}. ${widget.item.content[i]}")
            : widget.item.content[i];
        contentStrings.add(Text(
          itemContent,
          style: context.theme.textTheme.bodyMedium,
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
            labelText: "Prompt Content ${numToString(i + 1)}",
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

    Widget generateMLNotice() {
      Widget childWidget = Container();
      String aiText = "This content was generated with the help of AI.";
      if (isTopicBackground) {
        aiText =
            "The recommendation to include background information was made by AI.";
      }

      if (llmInfoOpen == true) {
        childWidget = Column(
          children: [
            Row(children: [
              const Icon(Icons.lightbulb_outline_rounded),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: Text(aiText)),
              IconButton(
                  onPressed: toggleLlmInfoOpen,
                  icon: const Icon(Icons.expand_less_rounded))
            ]),
            Text(widget.item.importance![0]),
          ],
        );
      } else {
        childWidget = Row(
          children: [
            const Icon(Icons.lightbulb_outline_rounded),
            const SizedBox(
              width: 10,
            ),
            Expanded(child: Text(aiText)),
            TextButton.icon(
                label: const Text('Show AI Rationale'),
                onPressed: toggleLlmInfoOpen,
                icon: const Icon(Icons.expand_more_rounded)),
          ],
        );
      }
      Widget llmInfo = Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 211, 239, 226),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: childWidget,
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      );
      return llmInfo;
    }

    Widget generateTopicBackground() {
      Widget topicBackground = Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 211, 241, 255),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline_rounded),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(widget.item.guidance?[0] ?? "",
                        style: context.theme.textTheme.labelLarge),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          generateMLNotice(),
          const SizedBox(
            height: 5,
          ),
          Text(widget.item.guidance?[1] ?? "",
              style: context.theme.textTheme.bodyMedium),
          const SizedBox(
            height: 10,
          )
        ],
      );
      return topicBackground;
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
                        style: context.theme.textTheme.bodyMedium),
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
                labelText: 'Prompt Title',
                fieldController: itemTitle,
                isRequired: true,
              ),
              FormInput(
                labelText: 'Prompt Duration (in minutes)',
                fieldController: itemDuration,
                isRequired: true,
                inputType: TextInputType.number,
                width: 100,
                typeFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              ...generateFormContentItems(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                      label: const Text('Save'),
                      onPressed: () => updateItem(),
                      icon: const Icon(Icons.save)),
                ],
              ),
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
                    style: context.theme.textTheme.bodyMedium),
              ),
              Row(
                children: [
                  DeleteIcon(
                    deleteCallback: deleteItem,
                    agendaPart: "prompt",
                  ),
                  IconButton(
                      onPressed: () => toggleEditing(),
                      icon: const Icon(Icons.edit)),
                ],
              ),
            ],
          ),
          if (widget.item.duration != null &&
              widget.item.duration!.getMinutes() !=
                  widget.parentDuration.getMinutes())
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.timer_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("${widget.item.duration!.minutes} minutes"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          if (isTopicBackground) generateTopicBackground(),
          if (widget.item.importance != null && !isTopicBackground) generateMLNotice(),
          ...generateContentItems(),
        ],
      );
    }

    return itemWidget;
  }
}
