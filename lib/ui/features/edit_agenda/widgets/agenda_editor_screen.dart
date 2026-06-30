import 'package:agenda_wizard/routing/router.dart';
import 'package:agenda_wizard/routing/routes.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../../../../styles/styles.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/widgets/agenda_editor.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/widgets/agenda_pdf_view.dart';
import 'package:flutter/material.dart';

class AgendaEditorScreen extends StatefulWidget {
  const AgendaEditorScreen({super.key, required this.viewModel});

  final AgendaEditorViewmodel viewModel;

  @override
  State<AgendaEditorScreen> createState() => _AgendaEditorScreenState();
}

class _AgendaEditorScreenState extends State<AgendaEditorScreen> {
  bool editMode = true;

  int saveStatus =
      0; // 0 = not saved, 1 = saving, 2 = saved successfully, -1 = error

  void toggleEditMode() {
    if (editMode == true) {
      widget.viewModel.saveCurrentEventPlanToHistory();
    }
    setState(() {
      editMode = !editMode;
    });
  }

  Future<void> updateAgenda() async {
    setState(() {
      saveStatus = 1; // 1 = saving
    });

    CustomResult<void> result = await widget.viewModel.updateAgenda(widget.viewModel.eventPlan);

    if (result is Ok) {
      setState(() {
        saveStatus = 2; // 2 = saved successfully
      });
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      context.go(Routes.agendas);
    } else {
      setState(() {
        saveStatus = -1; // -1 = error
      });
    }
  }

  Future<void>saveAgendaCopy() async {
    setState(() {
      saveStatus = 1; // 1 = saving
    });

    CustomResult<String> result = await widget.viewModel.saveAgenda();

    if (result is Ok) {
      setState(() {
        saveStatus = 2; // 2 = saved successfully
      });
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      context.go(Routes.agendas);
    } else {
      setState(() {
        saveStatus = -1; // -1 = error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Container(
        color: context.theme.colorScheme.surfaceContainer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (user != null)
                    ? SizedBox(
                        width: 200,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                              label: const Text('Agenda List'),
                              onPressed: () => router.go(Routes.agendas),
                              icon: const Icon(Icons.view_agenda)),
                        ),
                      )
                    : Row(
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(5),
                                minimumSize: Size.zero,
                              ),
                              onPressed: () => context.push(Routes.login),
                              child: const Text('Login')),
                          const SizedBox(
                            width: 140,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('to save agendas.'),
                            ),
                          ),
                        ],
                      ),
                editMode
                    ? const Text("Agenda Editor")
                    : const Text("Agenda Preview"),
                Row(
                  children: [
                    if (editMode && user != null) ..._generateSaveButton(),
                    SizedBox(
                      width: 100,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                            label: editMode
                                ? const Text('Export')
                                : const Text('Edit'),
                            onPressed: () => {},
                            icon: editMode
                                ? const Icon(Icons.import_export)
                                : const Icon(Icons.edit)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Center(
              child: ListenableBuilder(
                  listenable: widget.viewModel,
                  builder: (BuildContext context, _) {
                    if (editMode) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AgendaEditor(
                          viewModel: widget.viewModel,
                          saveStatus: saveStatus,
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AgendaPdfView(
                          viewModel: widget.viewModel,
                        ),
                      );
                    }
                  }),
            ),
          ]),
        ));
  }

  List<Widget> _generateSaveButton() {
    List<Widget> saveButtons = [];
    Widget saveCopyText = const Text("");
    Widget saveCopyIcon = const Icon(Icons.copy);

    if (widget.viewModel.eventPlan.id == null) {
      saveCopyText = const Text('Save');
      saveCopyIcon = const Icon(Icons.save);
    } else {
      Widget saveButton = SizedBox(
          width: 90,
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              label: const Text('Save'),
              onPressed: () => updateAgenda(),
              icon: const Icon(Icons.save),
            ),
          ));

      saveButtons.add(saveButton);
      saveCopyText = const Text('Save Copy');
    }

    Widget saveCopyButton = SizedBox(
        width: 150,
        child: Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            label: saveCopyText,
            onPressed: () => saveAgendaCopy(),
            icon: saveCopyIcon,
          ),
        ));
    saveButtons.add(saveCopyButton);
    return saveButtons;
  }
}
