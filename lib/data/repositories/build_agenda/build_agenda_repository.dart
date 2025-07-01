// import agenda building package here
// and use those functions

import 'package:agenda_wizard/utils/result.dart';

class BuildAgendaRepository {

  Future<Result<String>> buildAgenda() async {
    return Result.ok("Hello I am an agenda!");
  }


}
