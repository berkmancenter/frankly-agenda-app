import 'package:agenda_wizard/data/repositories/agenda/agenda_repository.dart';
import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

class AgendaEditorViewmodel extends ChangeNotifier {
  AgendaEditorViewmodel(
      {required this.agendaRepository, required this.eventPlan});

  final AgendaRepository agendaRepository;
  EventPlan eventPlan;

  String agendaPDFID = 'agendaId';
  final ExportDelegate exportDelegate = ExportDelegate(
    ttfFonts: {
      'Inter_500': 'assets/fonts/Inter/Inter_18pt-Medium.ttf',
      'Inter_600': 'assets/fonts/Inter/Inter_18pt-SemiBold.ttf',
      'Inter': 'assets/fonts/Inter/Inter_18pt-Regular.ttf',
      'Inter_regular': 'assets/fonts/Inter/Inter_18pt-Regular.ttf',
      'Inter_700': 'assets/fonts/Inter/Inter_18pt-Bold.ttf',
    },
  );

  Future<Result> updateAgenda(eventPlan) async {
    return await agendaRepository.updateEvent(eventPlan);
  }

  void updateItem(int agendaIndex, int sectionIndex, int itemIndex,
      String title, List<String> content) {
    AgendaItem newItem = AgendaItem(title: title, content: content);
    eventPlan.agendas[agendaIndex].sections[sectionIndex].items[itemIndex] =
        newItem;
    notifyListeners();
  }

  void updateSectionInfo(int agendaIndex, int sectionIndex, String sectionName,
      String description) {
    eventPlan.agendas[agendaIndex].sections[sectionIndex].name = sectionName;
    eventPlan.agendas[agendaIndex].sections[sectionIndex].description =
        description;
    notifyListeners();
  }

  void updateEventInfo(String eventName, String description) {
    eventPlan.eventName = eventName;
    eventPlan.eventDescription = description;
    notifyListeners();
  }

  Future<Result> exportPDF() async {
    try {
      final pdf = await exportDelegate.exportToPdfDocument(agendaPDFID);
      final bytes = await pdf.save();

      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File("$dir/${eventPlan.eventName}_discussion-guide.pdf");

      await file.writeAsBytes(bytes);

      if (Platform.isIOS || Platform.isMacOS) {
        final params = SaveFileDialogParams(sourceFilePath: file.path);
        final savedPath = await FlutterFileDialog.saveFile(params: params);
        if (savedPath != null) {
          return const Result.ok("Agenda saved.");
        } else {
          return Result.error(Exception("Agenda was not saved anywhere."),
              "Agenda was not saved anywhere.");
        }
      } else {
        // TODO: implement something else
        print('flutter_file_dialog not supported on this platform.');
        return Result.error(Exception("Unsupported platform for downloads."),
            "Unsupported platform for downloads.");
      }
    } catch (e) {
      print(e);
      return Result.error(
          Exception("Error saving pdf: {$e}"), "Error saving PDF.");
    }
  }
}
