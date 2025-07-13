import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:agenda_wizard/models/firebase_collections.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:agenda_wizard/utils/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AgendaRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Agenda> _userAgendas = [];

  Future<void> init() async {
    final agendaItems = await getAgendas();
  }

  Future<Result<List<Agenda>>?> getAgendas() async {
    // TODO
    // get the actual user from a service I think
    // 
    // return User.fromJson(doc.data()!);

    // final agendaDocs = await _firestore.collection(FirebaseCollections.agendas).get();
    // return Result.ok(AgendaModel.fromJson(agendaDocs.data()));
  }




}
