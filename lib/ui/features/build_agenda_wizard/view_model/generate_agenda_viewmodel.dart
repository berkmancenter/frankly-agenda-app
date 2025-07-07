// // Add needed data respositories for homepage
// import 'package:agenda_wizard/data/repositories/build_agenda/build_agenda_repository.dart';
// import 'package:agenda_wizard/utils/result.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_command/flutter_command.dart';

// class GenerateAgendaViewmodel extends ChangeNotifier{
// /// Constructor
//   GenerateAgendaViewmodel({required BuildAgendaRepository buildAgendaRepository
//   }) : _buildAgendaRepository = buildAgendaRepository;

//   /// Class variables
//   final BuildAgendaRepository _buildAgendaRepository;

//   Future<Result?> buildAgenda() async {
//     try {
//       final agendaResult = await _buildAgendaRepository.buildAgenda();
//       switch (agendaResult) {
//         case Ok<void>():
//           print('Generated agenda');
//           return agendaResult;
//         case Error():
//           print("Bad things agenda did not generate.");
//           return agendaResult;
//       }
//     } finally {
//       notifyListeners();
//     }
//   }
// }