import 'dart:typed_data';

import 'package:agenda_wizard/helpers/PdfSaver.dart';
import 'package:agenda_wizard/utils/custom_result.dart';

class StubPdfSaver implements PdfSaver {
  @override
  Future<CustomResult<String>> savePdf(Uint8List bytes, String filename) {
    throw UnsupportedError(
        'PDF saving is only supported on web, IOS, and OSX.');
  }
}

PdfSaver getPdfSaverImpl() => StubPdfSaver();
