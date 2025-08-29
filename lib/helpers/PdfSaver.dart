import 'dart:typed_data';

import 'package:agenda_wizard/utils/custom_result.dart';

import 'pdf_saver_stub.dart'
    if (dart.library.html) 'pdf_saver_web.dart'
    if (dart.library.io) "pdf_saver_ios-mac.dart" as saver;

abstract class PdfSaver {
  Future<CustomResult<String>> savePdf(Uint8List bytes, String filename);
}

PdfSaver getPdfSaver() => saver.getPdfSaverImpl();
