import 'package:agenda_wizard/styles/theme_util.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String buttonText;
  final Function callBack;
  final bool isDisabled;
  final bool isSecondary;

  const MainButton(
      {super.key,
      required this.buttonText,
      required this.callBack,
      this.isDisabled = false,
      this.isSecondary = false});

  @override
  Widget build(BuildContext context) {
    if (isSecondary) {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDisabled
                ? context.theme.colorScheme.primaryFixedDim
                : context.theme.colorScheme.surfaceContainerLowest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  4.0), // Adjust the radius value as needed
            ),
          ),
          onPressed: () => callBack(),
          child: Text(buttonText,
              style: context.theme.textTheme.labelSmall!
                  .copyWith(color: context.theme.colorScheme.primary)));
    } else {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDisabled
                ? context.theme.colorScheme.primaryFixedDim
                : context.theme.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  4.0), // Adjust the radius value as needed
            ),
          ),
          onPressed: () => callBack(),
          child: Text(buttonText,
              style: context.theme.textTheme.labelSmall!
                  .copyWith(color: context.theme.colorScheme.onPrimary)));
    }
  }
}
