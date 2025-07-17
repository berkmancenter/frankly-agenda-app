import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:agenda_wizard/models/agenda/agenda_section.dart';
import 'package:agenda_wizard/ui/core/themes/styles.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/utils/helper_functions.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

enum AgendaSaveStates { agendaSaved, saveError, adjusting }

class AgendaPdfView extends StatefulWidget {
  const AgendaPdfView({super.key, required this.viewModel});
  final AgendaEditorViewmodel viewModel;

  @override
  State<AgendaPdfView> createState() => _AgendaPdfViewState();
}

class _AgendaPdfViewState extends State<AgendaPdfView> {
  AgendaSaveStates agendaState = AgendaSaveStates.adjusting;
  String errorMessage = "";

  Future<void> savePDF() async {
    Result<void> result = await widget.viewModel.exportPDF();

    switch (result) {
      case Ok():
        setState(() {
          agendaState = AgendaSaveStates.agendaSaved;
          errorMessage = "";
        });
      case Error():
        setState(() {
          agendaState = AgendaSaveStates.saveError;
          errorMessage = result.displayError ?? "Unknown error.";
        });
    }
  }

  String screenTitle = "Here is your agenda.";
  String screenSubtext =
      "Double check that it looks okay, and then go ahead and download it!";

  @override
  Widget build(BuildContext context) {
    if (widget.viewModel.eventPlan.agendas.length > 1) {
      screenTitle = "Here are your agendas.";
      screenSubtext =
          "Double check that they look okay, and then go ahead and download them!";
    }

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          screenTitle,
          style: AppTextStyle.headline3,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          screenSubtext,
          style: AppTextStyle.body,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          child: agendaState == AgendaSaveStates.adjusting
              ? ElevatedButton(
                  child: const Text("Download"),
                  onPressed: () => savePDF(),
                )
              : null,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(4),
            ),
            width: double.infinity,
            child: agendaState == AgendaSaveStates.saveError
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Error: $errorMessage',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      IconButton(
                          onPressed: () => setState(() {
                                agendaState = AgendaSaveStates.adjusting;
                              }),
                          icon: const Icon(Icons.cancel))
                    ],
                  )
                : null),
        Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(4),
            ),
            width: double.infinity,
            child: agendaState == AgendaSaveStates.agendaSaved
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Agenda saved!',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      IconButton(
                          onPressed: () => setState(() {
                                agendaState = AgendaSaveStates.adjusting;
                              }),
                          icon: const Icon(Icons.cancel))
                    ],
                  )
                : null),
        const SizedBox(
          height: 10,
        ),
        ..._generateAgendaPDFs(
          widget.viewModel,
        ),
      ],
    );
  }

  List<Widget> _generateAgendaPDFs(AgendaEditorViewmodel viewModel) {
    List<Widget> agendas = [];

    // batch the widgets and their sizes 
    Widget EventInfo = 

    for (var i = 0; i < viewModel.eventPlan.agendas.length; i++) {
      agendas.add(AgendaPDF(
        viewModel: viewModel,
        agendaIndex: i,
      ));
    }

    return agendas;
  }
}

class AgendaPDFPage extends StatelessWidget {
  const AgendaPDFPage(
      {super.key, required this.viewModel, required this.pageWidgets, required this.frameID});
  final AgendaEditorViewmodel viewModel;
  final List<Widget> pageWidgets;
  final String frameID;

  @override
  Widget build(BuildContext context) {
    return ExportFrame(
      frameId:
          "${viewModel.agendaPDFID}_page_${DateTime.now().microsecondsSinceEpoch}",
      exportDelegate: viewModel.exportDelegate,
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
          child: Column(children: [...pageWidgets]),
        ),
      ),
    );
  }
}

class AgendaPDF extends StatelessWidget {
  const AgendaPDF(
      {super.key, required this.viewModel, required this.agendaIndex});

  final AgendaEditorViewmodel viewModel;
  final int agendaIndex;

  @override
  Widget build(BuildContext context) {
    return ExportFrame(
      frameId: viewModel.agendaPDFID,
      exportDelegate: viewModel.exportDelegate,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(viewModel.eventPlan.eventName,
                    style: AppTextStyle.headline3),
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
                  height: 5,
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 20,
                ),
                ..._generateSections(
                    viewModel.eventPlan.agendas[agendaIndex].sections),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _generateSections(List<AgendaSection> sections) {
    List<Widget> sectionWidgets = [];
    for (var i = 0; i < sections.length; i++) {
      sectionWidgets
          .add(AgendaPDFSection(section: sections[i], sectionIndex: i));
    }
    return sectionWidgets;
  }
}

class AgendaPDFSection extends StatelessWidget {
  const AgendaPDFSection(
      {super.key, required this.section, required this.sectionIndex});
  final AgendaSection section;
  final int sectionIndex;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(section.name, style: AppTextStyle.headline4),
      const SizedBox(
        height: 10,
      ),
      Text(
        section.description,
        style: AppTextStyle.body
            .merge(const TextStyle(fontStyle: FontStyle.italic)),
      ),
      const SizedBox(
        height: 20,
      ),
      ..._generatePDFItem(section.items),
      const SizedBox(
        height: 20,
      ),
    ]);
  }

  List<Widget> _generatePDFItem(List<AgendaItem> items) {
    List<Widget> itemWidgets = [];
    for (var i = 0; i < items.length; i++) {
      itemWidgets.add(AgendaPDFItem(
          item: items[i], itemIndex: i, totalItems: items.length));
    }
    return itemWidgets;
  }
}

class AgendaPDFItem extends StatelessWidget {
  const AgendaPDFItem(
      {super.key,
      required this.item,
      required this.itemIndex,
      required this.totalItems});
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
