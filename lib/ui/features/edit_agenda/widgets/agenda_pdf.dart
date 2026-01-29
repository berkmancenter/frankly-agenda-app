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
