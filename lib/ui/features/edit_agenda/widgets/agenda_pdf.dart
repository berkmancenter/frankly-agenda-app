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
  List<List<pw.Widget>> displayAgendas =
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
    List<pw.Widget> widgetList = [];
    for (var displayAgenda in displayAgendas) {
      for (var displayWidget in displayAgenda) {
        widgetList.add(displayWidget);
      }
      widgetList.add(pw.NewPage());
    }

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(45),
      build: (context) {
        return widgetList;
      },
    ));
  }

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
              // child: Padding(
              //   padding: const EdgeInsets.all(15),
              //   child: Padding(
              //     padding: const EdgeInsets.all(15),
              //     child: Column(children: [
              //       PdfPreview(
              //         // 2. Display the PDF
              //         build: (format) => displayPdf(),
              //       )
              //     ]),
              //   ),
              // ),
              child: PdfPreview(
                // 2. Display the PDF
                build: (format) => displayPdf(),
              )),
        ),
      ],
    );
  }

  void _createDisplayWidgets() {
    // Each agenda gets a new page
    int agendaIndex = 0;
    for (var agenda in widget.viewModel.eventPlan.agendas) {
      List<pw.Widget> agendaWidgets =
          _generateDisplayWidgets(widget.viewModel, agenda, agendaIndex);

      displayAgendas.add(agendaWidgets);
      agendaIndex = agendaIndex + 1;
    }
  }

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
      agendaWidgets.add(
        const PDFDividerLine().build(),
      );
      sectionIndex = sectionIndex + 1;
    }
    return agendaWidgets;
  }
}
