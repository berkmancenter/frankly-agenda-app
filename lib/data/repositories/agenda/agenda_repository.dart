import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/models/firebase_collections.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AgendaRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Agenda> _userAgendas = [];

  final List<EventPlan> _recentEventPlans = [];

  Future<void> init() async {
    final agendaItems = await getAgendas();
  }

  Future<CustomResult<List<Agenda>>?> getAgendas() async {
    // TODO
    // get the actual user from a service I think
    //
    // return User.fromJson(doc.data()!);

    // final agendaDocs = await _firestore.collection(FirebaseCollections.agendas).get();
    // return Result.ok(AgendaModel.fromJson(agendaDocs.data()));
  }

  Future<CustomResult<EventPlan>> updateEvent(EventPlan event) async {
    return CustomResult.ok(event);
  }

  List<EventPlan> get getRecentEventPlans {
    return _recentEventPlans;
  }

  void addRecentAgenda(EventPlan eventPlan) {
    EventPlan newPlan = eventPlan.deepCopy();
    _recentEventPlans.add(newPlan);
  }
}
