import 'package:agenda_wizard/data/repositories/agenda/agenda_repository.dart';
import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:flutter/material.dart';

class AgendaEditorViewmodel extends ChangeNotifier {

  AgendaEditorViewmodel({
    required this.agendaRepository,
  });

  final AgendaRepository agendaRepository;


}
