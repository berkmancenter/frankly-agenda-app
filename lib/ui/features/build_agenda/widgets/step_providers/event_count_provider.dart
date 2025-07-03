import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class EventCountProvider extends StepProvider{

  EventCountProvider() : super(isEnabled: true);

  final BehaviorSubject<int?> _eventCount =
      BehaviorSubject<int?>.seeded(null);

  final TextEditingController countController = TextEditingController();

  Stream<int?> getDurationRadioStream() => _eventCount.stream;
  int? getDurationRadioValue() => _eventCount.value;

  void updateCountValue(int newValue) {
    _eventCount.add(newValue);
  }

  @override
  int calculateNextStep() {
    return Steps.seriesEventLengthStep.index;
  }

  @override
  void dispose() {
    _eventCount.close();
  }
}