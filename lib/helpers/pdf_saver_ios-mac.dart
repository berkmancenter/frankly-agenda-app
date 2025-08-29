import 'dart:typed_data';

import 'package:agenda_wizard/helpers/PdfSaver.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class IosPdfSaver implements PdfSaver {
  @override
  Future<CustomResult<String>> savePdf(Uint8List bytes, String filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/$filename");
    await file.writeAsBytes(bytes);
    final params = SaveFileDialogParams(sourceFilePath: file.path);
    final savedPath = await FlutterFileDialog.saveFile(params: params);
    if (savedPath != null) {
      return const CustomResult.ok("Agenda saved.");
    } else {
      return CustomResult.error(Exception("Agenda was not saved anywhere."),
          "Agenda was not saved anywhere.");
    }
  }
}

PdfSaver getPdfSaverImpl() => IosPdfSaver();
