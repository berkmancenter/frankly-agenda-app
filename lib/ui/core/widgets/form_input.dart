import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormInput extends StatelessWidget {
  const FormInput(
      {super.key,
      required this.labelText,
      required this.fieldController,
      required this.isRequired,
      this.changeCallback,
      this.focusNode,
      this.hintText,
      this.inputType,
      this.typeFormatters = const []});

  final String labelText;
  final TextEditingController fieldController;
  final String? hintText;
  final bool isRequired;
  final Function? changeCallback;
  final FocusNode? focusNode;
  final TextInputType? inputType;
  final List<TextInputFormatter> typeFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          labelText,
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
          ),
          controller: fieldController,
          validator: (value) {
            if (isRequired) {
              if (value == null || value.isEmpty) {
                return 'Field is required.';
              }
            }
            return null;
          },
          onChanged: (newValue) {
            if (changeCallback != null) {
              changeCallback!(newValue);
            }
          },
          focusNode: focusNode,
          keyboardType: inputType,
          inputFormatters: [...typeFormatters],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
