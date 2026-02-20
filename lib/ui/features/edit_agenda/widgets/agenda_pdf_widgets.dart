import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:agenda_wizard/models/agenda/agenda_section.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/utils/helper_functions.dart';

class EventInfoPDF {
  const EventInfoPDF({required this.viewModel, required this.agendaIndex});

  final AgendaEditorViewmodel viewModel;
  final int agendaIndex;

  pw.Widget build() {
    return pw.Column(
      mainAxisSize: pw.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        pw.SizedBox(
          height: 10,
        ),
        pw.Text(viewModel.eventPlan.eventName,
            style: pw.TextStyle(
              fontStyle: pw.FontStyle.normal,
              fontWeight: pw.FontWeight.bold,
              fontSize: 22,
              height: 1.1,
            ),
            textAlign: pw.TextAlign.center),
        pw.SizedBox(
          height: 10,
        ),
        viewModel.eventPlan.agendas.length > 1
            ? pw.Text("Agenda ${numToString(agendaIndex + 1)}",
                style: pw.TextStyle(
                  fontSize: 10,
                  fontStyle: pw.FontStyle.italic,
                  height: 1.2,
                ),
                textAlign: pw.TextAlign.center)
            : pw.SizedBox.shrink(),
        viewModel.eventPlan.agendas.length > 1
            ? pw.SizedBox(
                height: 10,
              )
            : pw.SizedBox.shrink(),
        pw.Text(viewModel.eventPlan.eventDescription,
            style: pw.TextStyle(
              fontStyle: pw.FontStyle.normal,
              fontSize: 12,
              height: 1.5,
            ),
            textAlign: pw.TextAlign.center),
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
          PDFDividerChunk().build(),
          pw.SizedBox(
            height: 15,
          ),
          pw.Text(
            section.name,
            style: pw.TextStyle(
                fontStyle: pw.FontStyle.normal,
                fontSize: 16,
                height: 1.2,
                color: const PdfColor(.24, .27, .27)),
            textAlign: pw.TextAlign.left,
          ),
          pw.SizedBox(
            height: 10,
          ),
          pw.Text(section.description,
              style: pw.TextStyle(
                fontStyle: pw.FontStyle.italic,
                fontSize: 10,
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
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
                  height: 1.5,
                ),
                textAlign: pw.TextAlign.left,
              )
            : pw.Text(
                item.title,
                style: pw.TextStyle(
                  fontStyle: pw.FontStyle.normal,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
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
    return pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.SizedBox(
            height: 10,
          ),
          pw.Text(
            content,
            style: pw.TextStyle(
              fontStyle: pw.FontStyle.normal,
              fontSize: 12,
              height: 1,
            ),
            textAlign: pw.TextAlign.left,
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
              height: padding ?? 10,
              width: double.infinity,
            )),
        pw.SizedBox(
          height: padding ?? 10,
        ),
      ],
    );
  }
}

class PDFDividerChunk {
  pw.Widget build() {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
              padding: const pw.EdgeInsets.only(left: 2.5),
              child: pw.Container(
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(
                        color: PdfColor(.63, .81, .79),
                        width: 3,
                      ),
                    ),
                  ),
                  child: pw.SizedBox(
                    height: 30,
                    width: 14,
                  )))
        ]);
  }
}
