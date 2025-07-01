import 'package:agenda_wizard/data/repositories/build_agenda/build_agenda_repository.dart';
import 'package:agenda_wizard/utils/result.dart';

class BuildAgendaViewmodel {
  final BuildAgendaRepository _buildAgendaRepository;
  /// Constructor
  BuildAgendaViewmodel({
    required BuildAgendaRepository buildAgendaRepository
  }) : _buildAgendaRepository = buildAgendaRepository;

  Future<Result> _buildAgenda() async {
    return Result.ok(null);
  }
  
}