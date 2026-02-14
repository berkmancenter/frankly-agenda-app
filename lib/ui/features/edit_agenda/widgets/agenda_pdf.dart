import 'dart:typed_data';
import 'package:agenda_wizard/ui/core/widgets/main_button.dart';

import '../../../../../styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AgendaPdf {
  final pdf = pw.Document();
  void generatePDF() {
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Invoice',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 12),
            pw.Text(
              'Body text looks normal',
              style: pw.TextStyle(fontSize: 10),
            ),
          ],
        );
      },
    ));
  }

  Future<void> print() async {
    await Printing.layoutPdf(
      onLayout: (format) => pdf.save(),
    );
  }
}

class AgendaPDFDisplay2 extends StatelessWidget {
  const AgendaPDFDisplay2({super.key});

  Future<Uint8List> displayPdf() {
    final pdf = pw.Document();
    _filloutPDF(pdf);
    return pdf.save();
  }

  void _filloutPDF(pdf) {
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Invoice',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 12),
            pw.Text(
              'Body text looks normal',
              style: pw.TextStyle(fontSize: 10),
            ),
          ],
        );
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
}
