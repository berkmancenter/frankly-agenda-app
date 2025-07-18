import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:agenda_wizard/models/agenda/agenda_section.dart';
import 'package:agenda_wizard/ui/core/themes/styles.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

class AgendaPDFDisplay extends StatelessWidget {
  const AgendaPDFDisplay({
    super.key,
    required this.viewModel,
    required this.pageWidgets,
  });
  final AgendaEditorViewmodel viewModel;
  final List<Widget> pageWidgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.onTertiary,
        border: Border.all(
          color: context.theme.colorScheme.onTertiary,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [...pageWidgets]),
      ),
    );
  }
}

class AgendaPDFPage extends StatelessWidget {
  const AgendaPDFPage(
      {super.key,
      required this.viewModel,
      required this.pageWidgets,
      required this.frameID});
  final AgendaEditorViewmodel viewModel;
  final List<Widget> pageWidgets;
  final String frameID;

  @override
  Widget build(BuildContext context) {
    return ExportFrame(
      frameId: frameID,
      exportDelegate: viewModel.exportDelegate,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.colorScheme.onTertiary,
            border: Border.all(
              color: context.theme.colorScheme.onTertiary,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [...pageWidgets]),
          ),
        ),
      ),
    );
  }
}

class EventInfoPDF extends StatelessWidget {
  const EventInfoPDF(
      {super.key, required this.viewModel, required this.agendaIndex});

  final AgendaEditorViewmodel viewModel;
  final int agendaIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(viewModel.eventPlan.eventName, style: AppTextStyle.headline3),
        const SizedBox(
          height: 10,
          width: double.infinity,
        ),
        viewModel.eventPlan.agendas.length > 1
            ? Text("Agenda ${numToString(agendaIndex + 1)}",
                style: AppTextStyle.headlineSmall)
            : const Text(""),
        viewModel.eventPlan.agendas.length > 1
            ? const SizedBox(
                height: 10,
                width: double.infinity,
              )
            : const SizedBox(
                height: 0,
              ),
        Text(
          viewModel.eventPlan.eventDescription,
          style: AppTextStyle.subhead,
        ),
        const SizedBox(
          height: 20,
          width: double.infinity,
        ),
      ],
    );
  }
}

class SectionInfoPDF extends StatelessWidget {
  const SectionInfoPDF(
      {super.key, required this.section, required this.sectionIndex});
  final AgendaSection section;
  final int sectionIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            section.name,
            style: AppTextStyle.headline4,
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(section.description,
              style: AppTextStyle.body
                  .merge(const TextStyle(fontStyle: FontStyle.italic)),
              textAlign: TextAlign.left),
          const SizedBox(
            height: 20,
          ),
        ]);
  }
}

class ItemInfoPDF extends StatelessWidget {
  const ItemInfoPDF({
    super.key,
    required this.item,
    required this.itemIndex,
    required this.totalItems,
  });
  final AgendaItem item;
  final int itemIndex;
  final int totalItems;

  List<Widget> _generateContentItems() {
    List<Widget> contentStrings = [];
    for (var i = 0; i < item.content.length; i++) {
      contentStrings.add(
        const SizedBox(
          height: 10,
        ),
      );
      contentStrings.add(Text(
        item.content[i],
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        totalItems > 1
            ? Text(
                "${itemIndex + 1}. ${item.title}",
                style: AppTextStyle.bodyMedium,
                textAlign: TextAlign.left,
              )
            : Text(
                item.title,
                style: AppTextStyle.bodyMedium,
                textAlign: TextAlign.left,
              ),
        ..._generateContentItems(),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
