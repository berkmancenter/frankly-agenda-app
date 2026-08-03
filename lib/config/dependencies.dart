import 'package:agenda_wizard/data/repositories/agenda/agenda_repository.dart';
import 'package:agenda_wizard/data/repositories/auth/auth_repository.dart';
import 'package:agenda_wizard/data/repositories/build_agenda/build_agenda_repository.dart';
import 'package:agenda_wizard/data/repositories/user/user_repository.dart';
import 'package:agenda_wizard/providers/agendaProvider.dart';
import 'package:agenda_wizard/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providersLocal {
  final userRepo = UserRepository();
  final authRepo = AuthRepository(userRepo);
  final agendaRepo = AgendaRepository();
  final buildAgendaRepo = BuildAgendaRepository();
  
  return [
    ChangeNotifierProvider(
      create: (context) =>
          userRepo, // add in functionality to LocalDataservice class to actually get users
    ),
    ChangeNotifierProvider(
      create: (context) => agendaRepo,
    ),
    Provider(
      create: (context) => buildAgendaRepo,
    ),
    ChangeNotifierProvider(
        create: (context) => UserProvider(userRepo)),
    ChangeNotifierProvider(
      create: (context) => authRepo,
    ),
    ChangeNotifierProvider(create: (context) => AgendaProvider(agendaRepo)),

  ];
}
