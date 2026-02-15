import 'dart:typed_data';
import 'package:agenda_wizard/ui/core/widgets/divider_line.dart';
import 'package:agenda_wizard/ui/core/widgets/main_button.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/widgets/agenda_pdf_widgets.dart';

import '../../../../../styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AgendaPDF extends StatefulWidget {
  const AgendaPDF({super.key, required this.viewModel});
  final AgendaEditorViewmodel viewModel;

  @override
  State<AgendaPDF> createState() => _AgendaPDFState();
}

class _AgendaPDFState extends State<AgendaPDF> {
  List<pw.Widget> displayWidgets =
      []; // list of all agenda widgets for entire event (any type of widget) used for measuring

  List<pw.Widget> displayAgendas =
      []; // list of PDF Agenda Displays (AgendaPDFDisplay Widget)

  @override
  void initState() {
    super.initState();

    _createDisplayWidgets();
  }

  Future<Uint8List> displayPdf() {
    final pdf = pw.Document();
    _filloutPDF(pdf);
    return pdf.save();
  }

  void _filloutPDF(pdf) {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (context) {
        return displayAgendas;
      },
    ));
  }

  //   void _filloutPDF(pdf) {
  //   for (var agenda in displayAgendas) {
  //     pdf.addPage(pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       margin: pw.EdgeInsets.all(32),
  //       build: (context) {
  //         return pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           children: [
  //             pw.Text(
  //               'Invoice',
  //               style:
  //                   pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
  //             ),
  //             pw.SizedBox(height: 12),
  //             pw.Text(
  //               'Body text looks normal',
  //               style: pw.TextStyle(fontSize: 10),
  //             ),
  //           ],
  //         );
  //       },
  //     ));
  //   }
  // }

  Future<void> downloadPDF() async {
    final pdf = pw.Document();
    _filloutPDF(pdf);
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MainButton(
            buttonText: "Download PDF",
            callBack: downloadPDF,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.theme.colorScheme.onTertiary,
            border: Border.all(
              color: context.theme.colorScheme.onTertiary,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: SizedBox(
            height: 1100,
            width: 900,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: PdfPreview(
                // 2. Display the PDF
                build: (format) => displayPdf(),
              ),
              //child: Text("HI"),
            ),
          ),
        ),
      ],
    );
  }

  void _createDisplayWidgets() {
    List<pw.Widget> pdfAgendas = [];

    // Each agenda gets a new page
    int agendaIndex = 0;
    for (var agenda in widget.viewModel.eventPlan.agendas) {
      List<pw.Widget> agendaWidgets =
          _generateDisplayWidgets(widget.viewModel, agenda, agendaIndex);
      // build agenda displays
      AgendaPDFDisplay newAgenda = AgendaPDFDisplay(
        pageWidgets: agendaWidgets,
        viewModel: widget.viewModel,
      );
      pdfAgendas.add(newAgenda.build());

      agendaIndex = agendaIndex + 1;

      for (var agendaWidget in agendaWidgets) {
        displayWidgets.add(agendaWidget);
      }
    }
    displayAgendas = pdfAgendas;
  }

  // void _generateAgendaPDFPages(List<double> widgetHeights) {
  //   List<AgendaPDFPage> agendaPDFPages = [];
  //   const pageHeightLimit = 1100.0;

  //   // Each agenda gets a new page
  //   int agendaIndex = 0;
  //   for (var agenda in widget.viewModel.eventPlan.agendas) {
  //     // Rebuild our display widgets
  //     List<Widget> agendaWidgets =
  //         _generateDisplayWidgets(widget.viewModel, agenda, agendaIndex);

  //     List<Widget> currPageWidgets = [];
  //     // build pages based on height
  //     double currentHeight = 300;
  //     int agendaWidgetCounter = 0;
  //     for (var agendaWidget in agendaWidgets) {
  //       double height = widgetHeights[agendaWidgetCounter];
  //       currentHeight = currentHeight + height;
  //       if (currentHeight > pageHeightLimit ||
  //           agendaWidgetCounter == agendaWidgets.length - 1) {
  //         AgendaPDFPage newPage = AgendaPDFPage(
  //           frameID: "0",
  //           pageWidgets: currPageWidgets,
  //           viewModel: widget.viewModel,
  //         );
  //         // add to PDF page list
  //         agendaPDFPages.add(newPage);

  //         // and reset curr page widgets
  //         currPageWidgets = [];
  //         currentHeight = 300 + height;
  //       }
  //       currPageWidgets.add(agendaWidget);
  //       agendaWidgetCounter = agendaWidgetCounter + 1;
  //     }
  //     agendaIndex = agendaIndex + 1;
  //   }
  //   displayAgendas = agendaPDFPages;
  // }

  List<pw.Widget> _generateDisplayWidgets(
      AgendaEditorViewmodel viewModel, agenda, int agendaIndex) {
    // First, get all of the sections we want in one list
    List<pw.Widget> agendaWidgets = [];

    // add event section
    agendaWidgets.add(
        EventInfoPDF(viewModel: viewModel, agendaIndex: agendaIndex).build());

    // get sections
    int sectionIndex = 0;
    for (var section in agenda.sections) {
      // add section info widget
      agendaWidgets.add(SectionInfoPDF(
        section: section,
        sectionIndex: sectionIndex,
      ).build());

      // get item widgets
      int itemIndex = 0;
      for (var item in section.items) {
        agendaWidgets.add(ItemInfoPDF(
          item: item,
          itemIndex: itemIndex,
          totalItems: section.items.length,
        ).build());
        itemIndex = itemIndex + 1;

        for (var content in item.content) {
          agendaWidgets.add(ItemContentPDF(content: content).build());
        }
        agendaWidgets.add(pw.SizedBox(
          height: 10,
        ));
      }
      // agendaWidgets.add(
      //   const PDFDividerLine().build(),
      // );
      sectionIndex = sectionIndex + 1;
    }
    return agendaWidgets;
  }
}
