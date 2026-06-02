import 'package:agenda_wizard/data/repositories/user/user_repository.dart';
import 'package:agenda_wizard/models/agenda/agenda.dart';
import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/models/firebase_collections.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AgendaRepository {
  List<Agenda> _userAgendas = [];

  final List<EventPlan> _recentEventPlans = [];

  Future<void> init() async {
    final agendaItems = await getAgendas();
  }

  Future<CustomResult<List<EventPlan>>> getEventPlans() async {
    // TODO
    // get the actual user from a service I think
    //
    // return User.fromJson(doc.data()!);
    List<EventPlan> eventPlans;
    try {
      final agendaDocs = await FirebaseFirestore.instance
          .collection(FirebaseCollections.agendas)
          .get();
      eventPlans = (agendaDocs as List)
          .map((item) => EventPlan.fromJson(item as Map<String, dynamic>))
          .toList();
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print("Access denied: Check your security rules.");
      } else if (e.code == 'unavailable') {
        print("Network issue: Firestore is currently unreachable.");
      } else {
        print("Firestore error: ${e.message}");
      }
      return CustomResult.error(Exception(e.message), "Error getting agendas.");
    } catch (e) {
      return CustomResult.error(
          Exception("Unknown error"), "Error getting agendas.");
    }
    return CustomResult.ok(eventPlans);
  }

  Future<CustomResult<EventPlan>> updateEvent(EventPlan event) async {
    return CustomResult.ok(event);
  }

  List<EventPlan> get getRecentEventPlans {
    return _recentEventPlans;
  }

  int getEventPlanCount() {
    return _recentEventPlans.length;
  }

  Future<void> addRecentAgenda(EventPlan eventPlan, UserModel? currUser) async {
    EventPlan newPlan = eventPlan.deepCopy();
    _recentEventPlans.add(newPlan);

    if (currUser != null) {
      await storeAgenda(newPlan, currUser);
    }
  }

  Future<CustomResult<String>> storeAgenda(
      EventPlan eventPlan, UserModel currUser) async {
    print('DEBUG: storing agenda for user id: ${currUser.id}');
    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(currUser.id);
      await userRef
          .collection(FirebaseCollections.agendas)
          .add(eventPlan.toJson());
      print(
          'DEBUG: Firestore instance: ${FirebaseFirestore.instance.settings}');
      print('DEBUG: agenda stored at: ${userRef.path}');
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print("Access denied: Check your security rules.");
      } else if (e.code == 'unavailable') {
        print("Network issue: Firestore is currently unreachable.");
      } else {
        print("Firestore error: ${e.message}");
      }
      return CustomResult.error(Exception(e.message), "Error storing agenda.");
    } catch (e) {
      return CustomResult.error(
          Exception("Unknown error"), "Error storing agenda.");
    }
    return const CustomResult.ok("Agenda stored successfully.");
  }
}
