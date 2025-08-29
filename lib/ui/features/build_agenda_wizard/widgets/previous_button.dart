import 'package:agenda_wizard/ui/core/widgets/main_button.dart';
import 'package:flutter/material.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({super.key, required this.returnFunc});

  final Function returnFunc;

  @override
  Widget build(BuildContext context) {
    return MainButton(
            callBack: returnFunc,
            buttonText: "Previous",
            isSecondary: true,
          );
  }
}
