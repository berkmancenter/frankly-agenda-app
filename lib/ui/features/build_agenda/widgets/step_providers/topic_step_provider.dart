import 'package:agenda_wizard/ui/features/build_agenda/widgets/step_providers/step_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TopicStepProvider extends StepProvider {

  TopicStepProvider() : super(isEnabled: false);

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
    int currStepIndex = wizardController.getStepIndex(this);
    return currStepIndex + 1;
  }

  @override
  void dispose() {
    topicDescriptionController.dispose();
    topicController.dispose();
  }
}
