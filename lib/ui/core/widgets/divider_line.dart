import 'package:agenda_wizard/ui/core/themes/styles.dart';
import 'package:flutter/material.dart';

class DividerLine extends StatelessWidget {
  final double? padding;
  const DividerLine({super.key, this.padding});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: context.theme.colorScheme
                      .surfaceContainer, // Customize border color
                  width: 1, // Customize border width
                ),
              ),
            ),
            child: SizedBox(
              height: padding ?? 20,
              width: double.infinity,
            )),
        SizedBox(
          height: padding ?? 20,
        ),
      ],
    );
  }
}
