import 'dart:typed_data';

import 'package:agenda_wizard/ui/features/edit_agenda/widgets/agenda_pdf.dart';

import '../../../../../styles/styles.dart';
import 'package:agenda_wizard/ui/core/widgets/divider_line.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/widgets/agenda_pdf_widgets.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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

  List<String> frameIDs = [];

  List<Widget> displayWidgets = []; // list of all agenda widgets for entire event (any type of widget) used for measuring

  List<Widget> displayAgendas = []; // list of PDF Agenda Displays (AgendaPDFDisplay Widget)

  String screenTitle = "Here is your agenda.";
  String screenSubtext =
      "Double check that it looks okay, and then go ahead and download it!";

  @override
  void initState() {
    super.initState();
    // _createDisplayWidgets();
  }

  Future<void> savePdF() async {
    List<double> widgetHeights =
        await _measureWidgets(displayWidgets, widget.viewModel); // get added heights of all widgets 

    setState(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _buildPDF();
      });
    });
  }

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
          style: context.theme.textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          screenSubtext,
          style: context.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          child: agendaState == AgendaSaveStates.adjusting
              ? ElevatedButton(
                  child: const Text("Download"),
                  onPressed: () => savePdF(),
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
                          'Agenda downloaded!',
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
        AgendaPDF(viewModel: widget.viewModel),
      ],
    );
  }

  // void _createDisplayWidgets() {
  //   List<Widget> pdfAgendas = [];

  //   // Each agenda gets a new page
  //   int agendaIndex = 0;
  //   for (var agenda in widget.viewModel.eventPlan.agendas) {
  //     List<Widget> agendaWidgets =
  //         _generateDisplayWidgets(widget.viewModel, agenda, agendaIndex);
  //     // build agenda displays
  //     AgendaPDFDisplay newAgenda = AgendaPDFDisplay(
  //       pageWidgets: agendaWidgets,
  //       viewModel: widget.viewModel,
  //     );
  //     pdfAgendas.add(newAgenda);

  //     agendaIndex = agendaIndex + 1;

  //     for (var agendaWidget in agendaWidgets) {
  //       displayWidgets.add(agendaWidget);
  //     }
  //   }
  //   displayAgendas = pdfAgendas;
  // }

  Future<void> _buildPDF() async {
    CustomResult<void> result = await widget.viewModel.buildPDF(frameIDs);

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

  Future<List<double>> _measureWidgets(
      List<Widget> widgets, AgendaEditorViewmodel viewModel) async {
    List<double> widgetHeights = [];
    for (var widget in widgets) {
      double height = await viewModel.measureWidgetHeight(context, widget);
      widgetHeights.add(height);
    }
    return widgetHeights;
  }

  // List<Widget> _generateDisplayWidgets(
  //     AgendaEditorViewmodel viewModel, agenda, int agendaIndex) {
  //   // First, get all of the sections we want in one list
  //   List<Widget> agendaWidgets = [];

  //   // add event section
  //   agendaWidgets
  //       .add(EventInfoPDF(viewModel: viewModel, agendaIndex: agendaIndex));

  //   // get sections
  //   int sectionIndex = 0;
  //   for (var section in agenda.sections) {
  //     // add section info widget
  //     agendaWidgets.add(SectionInfoPDF(
  //       section: section,
  //       sectionIndex: sectionIndex,
  //     ));

  //     // get item widgets
  //     int itemIndex = 0;
  //     for (var item in section.items) {
  //       agendaWidgets.add(ItemInfoPDF(
  //         item: item,
  //         itemIndex: itemIndex,
  //         totalItems: section.items.length,
  //       ));
  //       itemIndex = itemIndex + 1;
  //     }
  //     agendaWidgets.add(
  //       const DividerLine(),
  //     );
  //     sectionIndex = sectionIndex + 1;
  //   }
  //   return agendaWidgets;
  // }

  // List<AgendaPDFDisplay2> _generateDisplayWidgets(AgendaEditorViewmodel viewModel, agenda, int agendaIndex) {
  //   List<AgendaPDFDisplay2> agendaWidgets = [const AgendaPDFDisplay2()];
  //   return agendaWidgets;
  // }

  

  // List<AgendaPDFDisplay2> _generateAgendaPDFPages(
  //     AgendaEditorViewmodel viewModel, List<double> widgetHeights) {
  //   frameIDs = [];
  //   List<AgendaPDFDisplay2> agendaPDFPages = [];
  //   const pageHeightLimit = 1100.0;

  //   // Each agenda gets a new page
  //   int agendaIndex = 0;
  //   for (var agenda in viewModel.eventPlan.agendas) {
  //     agendaPDFPages.add();
  //     // Rebuild our display widgets
  //     // List<AgendaPDFDisplay2> agendaWidgets =
  //     //     _generateDisplayWidgets(viewModel, agenda, agendaIndex);

  //   //   List<Widget> currPageWidgets = [];
  //   //   // build pages based on height
  //   //   double currentHeight = 300;
  //   //   int agendaWidgetCounter = 0;
  //   //   for (var agendaWidget in agendaWidgets) {
  //   //     double height = widgetHeights[agendaWidgetCounter];
  //   //     currentHeight = currentHeight + height;
  //   //     if (currentHeight > pageHeightLimit ||
  //   //         agendaWidgetCounter == agendaWidgets.length - 1) {
  //   //       // if it makes the page too tall, create a new page from previous widget list
  //   //       String frameID =
  //   //           "${viewModel.agendaPDFID}_page${agendaPDFPages.length}_${DateTime.now().microsecondsSinceEpoch}";
  //   //       frameIDs.add(frameID);
  //   //       AgendaPDFPage newPage = AgendaPDFPage(
  //   //         frameID: frameID,
  //   //         pageWidgets: currPageWidgets,
  //   //         viewModel: viewModel,
  //   //       );
  //   //       // add to PDF page list
  //   //       agendaPDFPages.add(newPage);

  //   //       // and reset curr page widgets
  //   //       currPageWidgets = [];
  //   //       currentHeight = 300 + height;
  //   //     }
  //   //     currPageWidgets.add(agendaWidget);
  //   //     agendaWidgetCounter = agendaWidgetCounter + 1;
  //   //   }

  //   //   agendaIndex = agendaIndex + 1;
  //   }
  //   return agendaPDFPages;
  // }
}