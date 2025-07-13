import 'package:agenda_wizard/routing/router.dart';
import 'package:agenda_wizard/routing/routes.dart';
import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/edit_agenda/view_model/agenda_editor_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AgendaEditor extends StatelessWidget {
  const AgendaEditor({super.key, required this.viewModel});

  final AgendaEditorViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => router.go(Routes.agendas),
                    icon: const Icon(Icons.view_agenda)),
                const Text("Agenda Editor"),
                const SizedBox(
                  width: 50,
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Agenda Name',
                    style: AppTextStyle.headline3,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'We\'ve got an agenda started for you. Take a look and feel free to edit it to suit your needs! When you\'re done, you can save or export it.',
                    style: AppTextStyle.eyebrowSmall,
                  ),
                  EditAgendaForm(
                    viewModel: viewModel,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditAgendaForm extends StatefulWidget {
  final AgendaEditorViewmodel viewModel;
  const EditAgendaForm({super.key, required this.viewModel});

  @override
  State<EditAgendaForm> createState() => _EditAgendaFormState();
}

class _EditAgendaFormState extends State<EditAgendaForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Text("hi"),
            FormInput(
              labelText: 'Agenda Name',
              fieldController: _name,
              isRequired: true,
            ),
          ],
        ));
  }
}
