import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/models/firebase_collections.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AgendaRepository extends ChangeNotifier {
  bool isLoading = false;

  final List<EventPlan> _recentEventPlans = [];
  List<EventPlan> _userEventPlans = [];

  List<EventPlan>? get userEventPlans => _userEventPlans;

  Future<void> init() async {
    //final agendaItems = await getEventPlans();
  }

  Future<void> loadEventPlans(UserModel currUser) async {
    isLoading = true;
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currUser.id)
          .collection('agendas')
          .get();

      _userEventPlans =
          snapshot.docs.map((doc) => EventPlan.fromJson(doc.data())).toList();
      isLoading = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print("Access denied: Check your security rules.");
      } else if (e.code == 'unavailable') {
        print("Network issue: Firestore is currently unreachable.");
      } else {
        print("Firestore error: ${e.message}");
      }
    } catch (e) {
      print("Unknown error: ${e.toString()}");
    }
  }

  List<EventPlan> get getRecentEventPlans {
    return _recentEventPlans;
  }

  int getEventPlanCount() {
    return _userEventPlans.length;
  }

  Future<void> addRecentAgenda(EventPlan eventPlan, UserModel? currUser) async {
    EventPlan newPlan = eventPlan.deepCopy();
    _recentEventPlans.add(newPlan);
  }

  Future<CustomResult<String>> storeAgenda(
      EventPlan eventPlan, UserModel currUser) async {
    print('DEBUG: storing agenda for user id: ${currUser.id}');
    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(currUser.id);

      DocumentReference agendaRef =
          userRef.collection(FirebaseCollections.agendas).doc();

      await agendaRef.set({
        ...eventPlan.toJson(),
        'id': agendaRef.id,
        'created': FieldValue.serverTimestamp(),
        'modified': FieldValue.serverTimestamp()
      });

      eventPlan.id = agendaRef.id;
      _userEventPlans.add(eventPlan);
      notifyListeners();

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

  Future<CustomResult<void>> updateEventPlan(EventPlan eventPlan) async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      return CustomResult.error(
          Exception("No user logged in"), "Please log in to update agendas.");
    }
    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid);

      QuerySnapshot snapshot = await userRef
          .collection(FirebaseCollections.agendas)
          .where('id', isEqualTo: eventPlan.id)
          .get();

      if (snapshot.docs.isEmpty) {
        return CustomResult.error(
            Exception("Agenda not found"), "Could not find agenda to update.");
      }

      await snapshot.docs.first.reference.set({...eventPlan.toJson(), 'modified': FieldValue.serverTimestamp()});

      int agendaIndex =
          _userEventPlans.indexWhere((agenda) => agenda.id == eventPlan.id);

      _userEventPlans[agendaIndex] = eventPlan;

      notifyListeners();
      return const CustomResult.ok(null);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print("Access denied: Check your security rules.");
      } else if (e.code == 'unavailable') {
        print("Network issue: Firestore is currently unreachable.");
      } else {
        print("Firestore error: ${e.message}");
      }
      return CustomResult.error(Exception(e.message), "Error deleting agenda.");
    } catch (e) {
      return CustomResult.error(
          Exception("Unknown error"), "Error deleting agenda.");
    }
  }

  Future<CustomResult<void>> deleteEventPlan(EventPlan eventPlan) async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      return CustomResult.error(
          Exception("No user logged in"), "Please log in to delete agendas.");
    }
    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid);
      QuerySnapshot snapshot = await userRef
          .collection(FirebaseCollections.agendas)
          .where('id', isEqualTo: eventPlan.id)
          .get();

      if (snapshot.docs.isEmpty) {
        return CustomResult.error(
            Exception("Agenda not found"), "Could not find agenda to delete.");
      }

      await snapshot.docs.first.reference.delete();
      _userEventPlans.removeWhere((plan) => plan.id == eventPlan.id);
      notifyListeners();
      return const CustomResult.ok(null);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print("Access denied: Check your security rules.");
      } else if (e.code == 'unavailable') {
        print("Network issue: Firestore is currently unreachable.");
      } else {
        print("Firestore error: ${e.message}");
      }
      return CustomResult.error(Exception(e.message), "Error deleting agenda.");
    } catch (e) {
      return CustomResult.error(
          Exception("Unknown error"), "Error deleting agenda.");
    }
  }
}
