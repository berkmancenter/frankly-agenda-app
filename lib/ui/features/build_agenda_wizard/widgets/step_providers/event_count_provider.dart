import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/step_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class EventCountProvider extends StepProvider{

  EventCountProvider(BuildAgendaViewmodel viewModel)
      : super(isEnabled: false, viewModel: viewModel);

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
  
  @override
  void addData() {
    if (_eventCount.value != null) {
      viewModel.addEventCount(_eventCount.value!);
    } else {
      throw Exception("Sending null data from a radio button. Weird.");
    }
  }
}