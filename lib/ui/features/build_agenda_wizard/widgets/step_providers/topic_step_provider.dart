import 'package:agenda_wizard/ui/features/build_agenda_wizard/view_model/build_agenda_viewmodel.dart';
import 'package:agenda_wizard/ui/features/build_agenda_wizard/widgets/step_providers/form_step_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TopicStepProvider extends FormStepProvider {
  TopicStepProvider(BuildAgendaViewmodel viewModel)
      : super(isEnabled: false, viewModel: viewModel);

  final _topic = BehaviorSubject<String>.seeded("");
  final _topicDescription = BehaviorSubject<String>.seeded("");

  final topicFocusNode = FocusNode();

  final TextEditingController topicController = TextEditingController();
  final TextEditingController topicDescriptionController =
      TextEditingController();

  String get topic {
    return _topic.value;
  }

  String get description {
    return _topicDescription.value;
  }

  @override
  Future<void> onShowing() async {
    if (viewModel.builder.topic != null) {
      _topic.add(viewModel.builder.topic!);
      topicController.text = _topic.value;
      nextStepEnabled = true;
    }
    if (viewModel.builder.topicDescription != null) {
      _topicDescription.add(viewModel.builder.topicDescription!);
      topicDescriptionController.text = _topicDescription.value;
    }

    if (_topic.value.isEmpty) {
      topicFocusNode.requestFocus();
    }
  }

  @override
  Future<void> onHiding() async {
    if (topicFocusNode.hasFocus) {
      topicFocusNode.unfocus();
    }
  }

  void updateTopic(String topic) {
    _topic.add(topic);
    if (_topic.value != "") {
      nextStepEnabled = true;
    } else {
      nextStepEnabled = false;
    }
  }

  void updateDescription(String description) {
    _topicDescription.add(description);
  }

  @override
  int calculateNextStep() {
    return Steps.audienceStep.index;
  }

  @override
  void dispose() {
    _topic.close();
    _topicDescription.close();
    topicDescriptionController.dispose();
    topicController.dispose();
    topicFocusNode.dispose();
    super.dispose();
  }

  @override
  void addData() {
    viewModel.addTopic(_topic.value, _topicDescription.value);
  }
}
