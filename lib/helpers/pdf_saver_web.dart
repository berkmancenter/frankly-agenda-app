// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:agenda_wizard/helpers/PdfSaver.dart';
import 'package:agenda_wizard/utils/custom_result.dart';

class WebPdfSaver implements PdfSaver {
  @override
  Future<CustomResult<String>> savePdf(Uint8List bytes, String filename) async {
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();
    html.Url.revokeObjectUrl(url);
    return const CustomResult.ok("Agenda saved to downloads.");
  }
}

PdfSaver getPdfSaverImpl() => WebPdfSaver();
