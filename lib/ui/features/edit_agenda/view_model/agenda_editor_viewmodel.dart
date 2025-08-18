import 'dart:async';

import 'package:agenda_wizard/data/repositories/agenda/agenda_repository.dart';
import 'package:agenda_wizard/data/repositories/build_agenda/build_agenda_repository.dart';
import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:agenda_wizard/models/agenda/agenda_section.dart';
import 'package:agenda_wizard/models/agenda/custom_duration.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';
import '../../../../../styles/app_styles.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

enum EditState { original, hasUpdated, hasReverted }

class AgendaEditorViewmodel extends ChangeNotifier {
  AgendaEditorViewmodel(
      {required this.agendaRepository,
      required this.eventPlan,
      required this.buildAgendaRepository}) {
    eventPlan = eventPlan.deepCopy();
    originalPlan = eventPlan.deepCopy();
  }

  final AgendaRepository agendaRepository;
  final BuildAgendaRepository buildAgendaRepository;

  EventPlan eventPlan;

  EditState editState = EditState.original;

  late EventPlan originalPlan;

  EventPlan? editedAndDisregarded;

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

  Future<CustomResult> updateAgenda(eventPlan) async {
    return await agendaRepository.updateEvent(eventPlan);
  }

  void saveCurrentEventPlanToHistory() {
    if (editState == EditState.hasUpdated) {
      agendaRepository.addRecentAgenda(eventPlan);
    }
  }

  void resetEventPlan() {
    editedAndDisregarded = eventPlan.deepCopy();
    eventPlan = originalPlan.deepCopy();

    editState = EditState.hasReverted;
    notifyListeners();
  }

  void undoReset() {
    if (editedAndDisregarded == null) {
      throw Exception("No event plan to revert to.");
    }
    eventPlan = editedAndDisregarded!.deepCopy();

    editState = EditState.hasUpdated;
    notifyListeners();
  }

  void deleteAgenda(int agendaIndex) {
    eventPlan.agendas.removeAt(agendaIndex);

    editState = EditState.hasUpdated;
    notifyListeners();
  }

  void addAgenda() {
    AgendaSection newSection = AgendaSection(
        name: "First Section",
        description:
            "This is the first section of your new agenda. Go ahead and edit, and don't forget to add prompts!",
        items: [],
        duration: CustomDuration(hours: 0, minutes: 10, seconds: 0));
    Agenda newAgenda = Agenda(sections: [newSection]);
    eventPlan.agendas.add(newAgenda);

    editState = EditState.hasUpdated;
    notifyListeners();
  }

  void updateSectionInfo(int agendaIndex, int sectionIndex, String sectionName,
      String description) {
    eventPlan.agendas[agendaIndex].sections[sectionIndex].name = sectionName;
    eventPlan.agendas[agendaIndex].sections[sectionIndex].description =
        description;

    editState = EditState.hasUpdated;
    notifyListeners();
  }

  void deleteSection(int agendaIndex, int sectionIndex) {
    eventPlan.agendas[agendaIndex].sections.removeAt(sectionIndex);
    editState = EditState.hasUpdated;
    notifyListeners();
  }

  void addSection(
      int agendaIndex, String title, String description, int minutes) {
    AgendaSection newSection = AgendaSection(
        name: title,
        description: description,
        items: [],
        duration: CustomDuration(hours: 0, minutes: minutes, seconds: 0));
    eventPlan.agendas[agendaIndex].sections.add(newSection);
    editState = EditState.hasUpdated;
    notifyListeners();
  }

  void updateEventInfo(String eventName, String description) {
    eventPlan.eventName = eventName;
    eventPlan.eventDescription = description;
    editState = EditState.hasUpdated;
    notifyListeners();
  }

  void updateItem(int agendaIndex, int sectionIndex, int itemIndex,
      String title, List<String> content) {
    AgendaItem newItem = AgendaItem(title: title, content: content);
    eventPlan.agendas[agendaIndex].sections[sectionIndex].items[itemIndex] =
        newItem;
    editState = EditState.hasUpdated;
    notifyListeners();
  }

  void deleteItem(int agendaIndex, int sectionIndex, int itemIndex) {
    eventPlan.agendas[agendaIndex].sections[sectionIndex].items
        .removeAt(itemIndex);
    editState = EditState.hasUpdated;
    notifyListeners();
  }

  void addItem(
      int agendaIndex, int sectionIndex, String title, String content) {
    AgendaItem newItem = AgendaItem(title: title, content: [content]);
    eventPlan.agendas[agendaIndex].sections[sectionIndex].items.add(newItem);
    editState = EditState.hasUpdated;
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

  Future<CustomResult> buildPDF(List<String> frameIds) async {
    try {
      final pdf = await exportDelegate.exportToPdfDocument(frameIds[0]);

      for (var i = 1; i < frameIds.length; i++) {
        final newPage = await exportDelegate.exportToPdfPage(frameIds[i]);
        pdf.addPage(newPage);
      }
      return await savePDF(pdf);
    } catch (e) {
      return CustomResult.error(
          Exception("Error building pdf: $e"), "Error building PDF.");
    }
  }

  Future<CustomResult> savePDF(var pdf) async {
    try {
      final bytes = await pdf.save();

      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File("$dir/${eventPlan.eventName}_discussion-guide.pdf");

      await file.writeAsBytes(bytes);

      if (Platform.isIOS || Platform.isMacOS) {
        final params = SaveFileDialogParams(sourceFilePath: file.path);
        final savedPath = await FlutterFileDialog.saveFile(params: params);
        if (savedPath != null) {
          return const CustomResult.ok("Agenda saved.");
        } else {
          return CustomResult.error(Exception("Agenda was not saved anywhere."),
              "Agenda was not saved anywhere.");
        }
      } else {
        // TODO: implement something else
        print('flutter_file_dialog not supported on this platform.');
        return CustomResult.error(
            Exception("Unsupported platform for downloads."),
            "Unsupported platform for downloads.");
      }
    } catch (e) {
      print(e);
      return CustomResult.error(
          Exception("Error saving pdf: {$e}"), "Error saving PDF.");
    }
  }
}
