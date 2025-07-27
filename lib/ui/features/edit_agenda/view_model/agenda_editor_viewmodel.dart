import 'dart:async';

import 'package:agenda_wizard/data/repositories/agenda/agenda_repository.dart';
import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
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
  
   void deleteSection(int agendaIndex, int sectionIndex) {
    eventPlan.agendas[agendaIndex].sections.removeAt(sectionIndex);
    notifyListeners();
  }

  void updateEventInfo(String eventName, String description) {
    eventPlan.eventName = eventName;
    eventPlan.eventDescription = description;
    notifyListeners();
  }

  Future<double> measureWidgetHeight(
      BuildContext context, Widget widget) async {
    final key = GlobalKey();

    final overlay = OverlayEntry(
      builder: (_) => Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Icon(
              Icons.post_add,
              size: 50,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "building PDF . . .",
              style: AppTextStyle.headline4,
            ),
            Center(
              child: IntrinsicHeight(
                child: Column(
                  key: key,
                  children: [Opacity(opacity: 0, child: widget)],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(overlay);
    await Future.delayed(const Duration(milliseconds: 100));

    final height = key.currentContext?.size?.height ?? 0;
    overlay.remove();
    return height;
  }

  Future<Result> buildPDF(List<String> frameIds) async {
    try {
      final pdf = await exportDelegate.exportToPdfDocument(frameIds[0]);

      for (var i = 1; i < frameIds.length; i++) {
        final newPage = await exportDelegate.exportToPdfPage(frameIds[i]);
        pdf.addPage(newPage);
      }
      return await savePDF(pdf);
    } catch (e) {
      return Result.error(
          Exception("Error building pdf: $e"), "Error building PDF.");
    }
  }

  Future<Result> savePDF(var pdf) async {
    try {
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
