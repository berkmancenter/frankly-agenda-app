import 'package:flutter/material.dart';

class AgendaCheckBox extends StatelessWidget {
  final String label;
  final bool? boxValue;
  final ValueChanged<bool?> onChangedFunction;

  const AgendaCheckBox(
      {super.key,
      required this.label,
      required this.boxValue,
      required this.onChangedFunction});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: boxValue,
      tristate: false,
      onChanged: onChangedFunction,
      title: Text(label),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }
}
