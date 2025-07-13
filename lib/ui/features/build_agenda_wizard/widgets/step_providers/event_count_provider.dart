import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class EventCountProvider extends FormStepProvider {
  EventCountProvider(BuildAgendaViewmodel viewModel)
      : super(isEnabled: false, viewModel: viewModel);

  final BehaviorSubject<int?> _eventCount = BehaviorSubject<int?>.seeded(null);

  final TextEditingController countController = TextEditingController();

  Stream<int?> getDurationRadioStream() => _eventCount.stream;
  int? getDurationRadioValue() => _eventCount.value;

  final eventFocusNode = FocusNode();

  @override
  Future<void> onShowing() async {
    if (_eventCount.value == null) {
      eventFocusNode.requestFocus();
    }
  }

  @override
  Future<void> onHiding() async {
    if (eventFocusNode.hasFocus) {
      eventFocusNode.unfocus();
    }
  }

  void updateCountValue(int newValue) {
    _eventCount.add(newValue);

    if (_eventCount.value != null) {
      nextStepEnabled = true;
    }
  }

  @override
  int calculateNextStep() {
    return Steps.seriesEventLengthStep.index;
  }

  @override
  void dispose() {
    _eventCount.close();
    countController.dispose();
    super.dispose();
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
