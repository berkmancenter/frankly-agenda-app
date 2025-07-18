import 'package:agenda_wizard/models/agenda/agenda_item.dart';
import 'package:agenda_wizard/models/agenda/agenda_section.dart';
import 'package:agenda_wizard/ui/core/themes/styles.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/utils/helper_functions.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

enum AgendaSaveStates { agendaSaved, saveError, adjusting }

// ignore: must_be_immutable, use_key_in_widget_constructors
abstract class HeightWidget implements Widget {
  double? height;
}

class AgendaPdfView extends StatefulWidget {
  const AgendaPdfView({super.key, required this.viewModel});
  final AgendaEditorViewmodel viewModel;

  @override
  State<AgendaPdfView> createState() => _AgendaPdfViewState();
}

class _AgendaPdfViewState extends State<AgendaPdfView> {
  AgendaSaveStates agendaState = AgendaSaveStates.adjusting;
  String errorMessage = "";

  List<String> frameIDs = [];

  List<HeightWidget> displayWidgets = [];

  List<Widget> displayAgendas = [];

  String screenTitle = "Here is your agenda.";
  String screenSubtext =
      "Double check that it looks okay, and then go ahead and download it!";

  @override
  void initState() {
    super.initState();
    createDisplayWidgets();
  }

  Future<void> savePdF() async {
    List<double> widgetHeights =
        await _measureWidgets(displayWidgets, widget.viewModel);

    setState(() {
      displayAgendas = _generateAgendaPDFPages(widget.viewModel, widgetHeights);

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await buildPDF();
      });
    });
  }

  Future<void> buildPDF() async {
    Result<void> result = await widget.viewModel.buildPDF(frameIDs);

    switch (result) {
      case Ok():
        setState(() {
          agendaState = AgendaSaveStates.agendaSaved;
          errorMessage = "";
        });
      case Error():
        setState(() {
          agendaState = AgendaSaveStates.saveError;
          errorMessage = result.displayError ?? "Unknown error.";
        });
    }
  }

  void createDisplayWidgets() {
    List<Widget> agendaPDFPages = [];

    // Each agenda gets a new page
    int agendaIndex = 0;
    for (var agenda in widget.viewModel.eventPlan.agendas) {
      List<HeightWidget> agendaWidgets =
          _generateDisplayWidgets(widget.viewModel, agenda, agendaIndex);
      // build agenda displays
      AgendaPDFDisplay newPage = AgendaPDFDisplay(
        pageWidgets: agendaWidgets,
        viewModel: widget.viewModel,
      );
      agendaPDFPages.add(newPage);

      agendaIndex = agendaIndex + 1;

      for (var agendaWidget in agendaWidgets) {
        displayWidgets.add(agendaWidget);
      }
    }
    displayAgendas = agendaPDFPages;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.viewModel.eventPlan.agendas.length > 1) {
      screenTitle = "Here are your agendas.";
      screenSubtext =
          "Double check that they look okay, and then go ahead and download them!";
    }

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          screenTitle,
          style: AppTextStyle.headline3,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          screenSubtext,
          style: AppTextStyle.body,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          child: agendaState == AgendaSaveStates.adjusting
              ? ElevatedButton(
                  child: const Text("Download"),
                  onPressed: () => savePdF(),
                )
              : null,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(4),
            ),
            width: double.infinity,
            child: agendaState == AgendaSaveStates.saveError
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Error: $errorMessage',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      IconButton(
                          onPressed: () => setState(() {
                                agendaState = AgendaSaveStates.adjusting;
                              }),
                          icon: const Icon(Icons.cancel))
                    ],
                  )
                : null),
        Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(4),
            ),
            width: double.infinity,
            child: agendaState == AgendaSaveStates.agendaSaved
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Agenda saved!',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      IconButton(
                          onPressed: () => setState(() {
                                agendaState = AgendaSaveStates.adjusting;
                              }),
                          icon: const Icon(Icons.cancel))
                    ],
                  )
                : null),
        const SizedBox(
          height: 10,
        ),
        ...displayAgendas
      ],
    );
  }

  Future<List<double>> _measureWidgets(
      List<HeightWidget> widgets, AgendaEditorViewmodel viewModel) async {
    List<double> widgetHeights = [];
    for (var widget in widgets) {
      double height = await viewModel.measureWidgetHeight(context, widget);
      widgetHeights.add(height);
    }
    return widgetHeights;
  }

  List<HeightWidget> _generateDisplayWidgets(
      AgendaEditorViewmodel viewModel, agenda, int agendaIndex) {
    // First, get all of the sections we want in one list
    List<HeightWidget> agendaWidgets = [];

    // add event section
    agendaWidgets
        .add(EventInfoPDF(viewModel: viewModel, agendaIndex: agendaIndex));

    // get sections
    int sectionIndex = 0;
    for (var section in agenda.sections) {
      // add section info widget
      agendaWidgets.add(SectionInfoPDF(
        section: section,
        sectionIndex: sectionIndex,
      ));

      // get item widgets
      int itemIndex = 0;
      for (var item in section.items) {
        agendaWidgets.add(ItemInfoPDF(
          item: item,
          itemIndex: itemIndex,
          totalItems: section.items.length,
        ));
        itemIndex = itemIndex + 1;
      }
      sectionIndex = sectionIndex + 1;
    }
    return agendaWidgets;
  }

  List<AgendaPDFPage> _generateAgendaPDFPages(
      AgendaEditorViewmodel viewModel, List<double> widgetHeights) {
    List<AgendaPDFPage> agendaPDFPages = [];
    const pageHeightLimit = 1100.0;

    // Each agenda gets a new page
    int agendaIndex = 0;
    for (var agenda in viewModel.eventPlan.agendas) {
      // First, get all of the sections we want in one list
      List<HeightWidget> agendaWidgets = _generateDisplayWidgets(viewModel, agenda, agendaIndex);

      // add event section
      // agendaWidgets
      //     .add(EventInfoPDF(viewModel: viewModel, agendaIndex: agendaIndex));

      // // // get sections
      // int sectionIndex = 0;
      // for (var section in agenda.sections) {
      //   // add section info widget
      //   agendaWidgets.add(SectionInfoPDF(
      //     section: section,
      //     sectionIndex: sectionIndex,
      //   ));

      //   // get item widgets
      //   int itemIndex = 0;
      //   for (var item in section.items) {
      //     agendaWidgets.add(ItemInfoPDF(
      //       item: item,
      //       itemIndex: itemIndex,
      //       totalItems: section.items.length,
      //     ));
      //     itemIndex = itemIndex + 1;
      //   }
      //   sectionIndex = sectionIndex + 1;
      // }

      List<Widget> currPageWidgets = [];
      // build pages based on height
      double currentHeight = 300;
      int agendaWidgetCounter = 0;
      for (var agendaWidget in agendaWidgets) {
        double height = widgetHeights[agendaWidgetCounter];
        currentHeight = currentHeight + height;
        if (currentHeight > pageHeightLimit) {
          // if it makes the page too tall, create a new page from previous widget list
          String frameID =
              "${viewModel.agendaPDFID}_page${agendaPDFPages.length}_${DateTime.now().microsecondsSinceEpoch}";
          frameIDs.add(frameID);
          AgendaPDFPage newPage = AgendaPDFPage(
            frameID: frameID,
            pageWidgets: currPageWidgets,
            viewModel: viewModel,
          );
          // add to PDF page list
          agendaPDFPages.add(newPage);

          // and reset curr page widgets
          currPageWidgets = [];
          currentHeight = 300 + height;
        }
        currPageWidgets.add(agendaWidget);
        agendaWidgetCounter = agendaWidgetCounter + 1;
      }

      agendaIndex = agendaIndex + 1;
    }
    return agendaPDFPages;
  }
}

class AgendaPDFDisplay extends StatelessWidget {
  const AgendaPDFDisplay({
    super.key,
    required this.viewModel,
    required this.pageWidgets,
  });
  final AgendaEditorViewmodel viewModel;
  final List<HeightWidget> pageWidgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.onTertiary,
        border: Border.all(
          color: context.theme.colorScheme.onTertiary,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [...pageWidgets]),
      ),
    );
  }
}

class AgendaPDFPage extends StatelessWidget {
  const AgendaPDFPage(
      {super.key,
      required this.viewModel,
      required this.pageWidgets,
      required this.frameID});
  final AgendaEditorViewmodel viewModel;
  final List<Widget> pageWidgets;
  final String frameID;

  @override
  Widget build(BuildContext context) {
    return ExportFrame(
      frameId: frameID,
      exportDelegate: viewModel.exportDelegate,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.colorScheme.onTertiary,
            border: Border.all(
              color: context.theme.colorScheme.onTertiary,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [...pageWidgets]),
          ),
        ),
      ),
    );
  }
}

class EventInfoPDF extends StatelessWidget implements HeightWidget {
  const EventInfoPDF(
      {super.key, required this.viewModel, required this.agendaIndex});

  final AgendaEditorViewmodel viewModel;
  final int agendaIndex;

  @override
  final double? height = null;

  @override
  set height(double? height) {
    height = height;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(viewModel.eventPlan.eventName, style: AppTextStyle.headline3),
        const SizedBox(
          height: 10,
          width: double.infinity,
        ),
        viewModel.eventPlan.agendas.length > 1
            ? Text("Agenda ${numToString(agendaIndex + 1)}",
                style: AppTextStyle.headlineSmall)
            : const Text(""),
        viewModel.eventPlan.agendas.length > 1
            ? const SizedBox(
                height: 10,
                width: double.infinity,
              )
            : const SizedBox(
                height: 0,
              ),
        Text(
          viewModel.eventPlan.eventDescription,
          style: AppTextStyle.subhead,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
      ],
    );
  }
}

class SectionInfoPDF extends StatelessWidget implements HeightWidget {
  const SectionInfoPDF(
      {super.key, required this.section, required this.sectionIndex});
  final AgendaSection section;
  final int sectionIndex;

  @override
  final double? height = null;

  @override
  set height(double? height) {
    height = height;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(section.name, style: AppTextStyle.headline4),
          const SizedBox(
            height: 10,
          ),
          Text(
            section.description,
            style: AppTextStyle.body
                .merge(const TextStyle(fontStyle: FontStyle.italic)),
          ),
        ]);
  }
}

class ItemInfoPDF extends StatelessWidget implements HeightWidget {
  const ItemInfoPDF({
    super.key,
    required this.item,
    required this.itemIndex,
    required this.totalItems,
  });
  final AgendaItem item;
  final int itemIndex;
  final int totalItems;

  @override
  final double? height = null;

  @override
  set height(double? height) {
    height = height;
  }

  List<Widget> _generateContentItems() {
    List<Widget> contentStrings = [];
    for (var i = 0; i < item.content.length; i++) {
      contentStrings.add(
        const SizedBox(
          height: 10,
        ),
      );
      contentStrings.add(Text(
        item.content[i],
        style: AppTextStyle.body,
      ));
      contentStrings.add(
        const SizedBox(
          height: 10,
        ),
      );
    }
    return contentStrings;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        totalItems > 1
            ? Text(
                "${itemIndex + 1}. ${item.title}",
                style: AppTextStyle.bodyMedium,
                textAlign: TextAlign.left,
              )
            : Text(
                item.title,
                style: AppTextStyle.bodyMedium,
                textAlign: TextAlign.left,
              ),
        ..._generateContentItems(),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
