import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:agenda_wizard/models/agenda/agenda_section.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../../styles/styles.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

class AgendaPDFDisplay {
  const AgendaPDFDisplay({
    required this.viewModel,
    required this.pageWidgets,
  });
  final AgendaEditorViewmodel viewModel;
  final List<pw.Widget> pageWidgets;

  pw.Widget build() {
    return pw.Container(
      decoration: pw.BoxDecoration(
        color: PdfColor(1, 1, 1),
        border: pw.Border.all(
          color: PdfColor(1, 1, 1),
        ),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(15),
        child: pw.Column(children: pageWidgets),
      ),
    );
  }
}

// class AgendaPDFPage extends StatelessWidget {
//   const AgendaPDFPage(
//       {super.key,
//       required this.viewModel,
//       required this.pageWidgets,
//       required this.frameID});
//   final AgendaEditorViewmodel viewModel;
//   final List<Widget> pageWidgets;
//   final String frameID;

//   @override
//   Widget build(BuildContext context) {
//     return ExportFrame(
//       frameId: frameID,
//       exportDelegate: viewModel.exportDelegate,
//       child: Container(
//         decoration: BoxDecoration(
//           color: context.theme.colorScheme.onTertiary,
//           border: Border.all(
//             color: context.theme.colorScheme.onTertiary,
//           ),
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [...pageWidgets]),
//         ),
//       ),
//     );
//   }
// }

class EventInfoPDF {
  const EventInfoPDF({required this.viewModel, required this.agendaIndex});

  final AgendaEditorViewmodel viewModel;
  final int agendaIndex;

  pw.Widget build() {
    return pw.Column(
      mainAxisSize: pw.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.SizedBox(
          height: 10,
        ),
        pw.Text(viewModel.eventPlan.eventName,
            style: pw.TextStyle(
              fontStyle: pw.FontStyle.normal,
              fontWeight: pw.FontWeight.bold,
              fontSize: 24,
              height: 1.1,
            )),
        pw.SizedBox(
          height: 10,
        ),
        viewModel.eventPlan.agendas.length > 1
            ? pw.Text("Agenda ${numToString(agendaIndex + 1)}",
                style: pw.TextStyle(
                  fontStyle: pw.FontStyle.normal,
                  fontSize: 12,
                  height: 1.2,
                ))
            : pw.SizedBox.shrink(),
        viewModel.eventPlan.agendas.length > 1
            ? pw.SizedBox(
                height: 10,
              )
            : pw.SizedBox.shrink(),
        pw.Text(viewModel.eventPlan.eventDescription,
            style: pw.TextStyle(
              fontStyle: pw.FontStyle.normal,
              fontSize: 18,
              height: 1.5,
            )),
        pw.SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class SectionInfoPDF {
  const SectionInfoPDF({required this.section, required this.sectionIndex});
  final AgendaSection section;
  final int sectionIndex;

  pw.Widget build() {
    return pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.SizedBox(
            height: 20,
          ),
          pw.Text(
            section.name,
            style: pw.TextStyle(
              fontStyle: pw.FontStyle.normal,
              fontSize: 18,
              height: 1.2,
            ),
            textAlign: pw.TextAlign.left,
          ),
          pw.SizedBox(
            height: 10,
          ),
          pw.Text(section.description,
              style: pw.TextStyle(
                fontStyle: pw.FontStyle.italic,
                fontSize: 14,
                height: 1,
              ),
              textAlign: pw.TextAlign.left),
          pw.SizedBox(
            height: 20,
          ),
        ]);
  }
}

class ItemInfoPDF {
  const ItemInfoPDF({
    required this.item,
    required this.itemIndex,
    required this.totalItems,
  });
  final AgendaItem item;
  final int itemIndex;
  final int totalItems;

  pw.Widget build() {
    return pw.Column(
      mainAxisSize: pw.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        totalItems > 1
            ? pw.Text(
                "${itemIndex + 1}. ${item.title}",
                style: pw.TextStyle(
                  fontStyle: pw.FontStyle.normal,
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: pw.TextAlign.left,
              )
            : pw.Text(
                item.title,
                style: pw.TextStyle(
                  fontStyle: pw.FontStyle.normal,
                  fontSize: 14,
                  height: 1,
                ),
                textAlign: pw.TextAlign.left,
              ),
      ],
    );
  }
}

class ItemContentPDF {
  const ItemContentPDF({required this.content});
  final String content;

  pw.Widget build() {
    return pw.Column(children: [
      pw.SizedBox(
        height: 10,
      ),
      pw.Text(
        content,
        style: pw.TextStyle(
          fontStyle: pw.FontStyle.normal,
          fontSize: 14,
          height: 1,
        ),
      ),
      pw.SizedBox(
        height: 10,
      ),
    ]);
  }
}

class PDFDividerLine {
  final double? padding;
  const PDFDividerLine({this.padding});

  pw.Widget build() {
    return pw.Column(
      children: [
        pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(
                  color: PdfColor(.97, .95, .95), // Customize border color
                  width: 1, // Customize border width
                ),
              ),
            ),
            child: pw.SizedBox(
              height: padding ?? 20,
              width: double.infinity,
            )),
        pw.SizedBox(
          height: padding ?? 20,
        ),
      ],
    );
  }
}
