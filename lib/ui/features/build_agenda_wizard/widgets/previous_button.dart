import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({super.key, required this.returnFunc});

  final Function returnFunc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => returnFunc(),
      child: const Text("Previous"),
    );
  }
}
