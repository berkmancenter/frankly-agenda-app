import 'package:agenda_wizard/styles/theme_util.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String buttonText;
  final Function callBack;

  const MainButton(
      {super.key, required this.buttonText, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: context.theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(4.0), // Adjust the radius value as needed
          ),
        ),
        onPressed: () => callBack,
        child: Text(buttonText,
            style: context.theme.textTheme.labelSmall!
                .copyWith(color: context.theme.colorScheme.onPrimary)));
  }
}
