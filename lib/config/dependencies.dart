import 'package:agenda_wizard/data/repositories/agenda/agenda_repository.dart';
import 'package:agenda_wizard/data/repositories/auth/auth_repository.dart';
import 'package:agenda_wizard/data/repositories/build_agenda/build_agenda_repository.dart';
import 'package:agenda_wizard/data/repositories/user/user_repository.dart';
import 'package:agenda_wizard/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providersLocal {
  final userRepo = UserRepository();
  final authRepo = AuthRepository(userRepo);
  final agendaRepo = AgendaRepository();
  final buildAgendaRepo = BuildAgendaRepository();
  final agendaRepository = AgendaRepository();
  return [
    ChangeNotifierProvider(
      create: (context) =>
          userRepo, // add in functionality to LocalDataservice class to actually get users
    ),
    Provider(
      create: (context) => agendaRepo,
    ),
    Provider(
      create: (context) => buildAgendaRepo,
    ),
    Provider(
      create: (context) => agendaRepository,
    ),
    ChangeNotifierProvider(
        create: (context) => UserProvider(userRepo)),
    ChangeNotifierProvider(
      create: (context) => authRepo,
    )
  ];
}
