import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AudienceStepProvider extends FormStepProvider {
  AudienceStepProvider(BuildAgendaViewmodel viewModel)
      : super(isEnabled: false, viewModel: viewModel);

  final _audienceDescription = BehaviorSubject<String>.seeded("");

  final audienceFocusNode = FocusNode();

  final TextEditingController audienceController = TextEditingController();

  String get topic {
    return _audienceDescription.value;
  }

  String get description {
    return _audienceDescription.value;
  }

  @override
  Future<void> onShowing() async {
    if (viewModel.builder.audienceDescription != null) {
      _audienceDescription.add(viewModel.builder.audienceDescription!);
      audienceController.text = _audienceDescription.value;
      nextStepEnabled = true;
    }

    if (_audienceDescription.value.isEmpty) {
      audienceFocusNode.requestFocus();
    }
  }

  @override
  Future<void> onHiding() async {
    if (audienceFocusNode.hasFocus) {
      audienceFocusNode.unfocus();
    }
  }

  void updateAudience(String topic) {
    _audienceDescription.add(topic);
    if (_audienceDescription.value != "") {
      nextStepEnabled = true;
    } else {
      nextStepEnabled = false;
    }
  }

  @override
  int calculateNextStep() {
    return Steps.participantStep.index;
  }

  @override
  void dispose() {
    _audienceDescription.close();
    audienceController.dispose();
    audienceFocusNode.dispose();
    super.dispose();
  }

  @override
  void addData() {
    viewModel.addAudience(_audienceDescription.value);
  }
}
