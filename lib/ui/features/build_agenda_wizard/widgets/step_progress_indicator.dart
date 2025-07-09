import 'package:flutter/material.dart';

class StepsProgressIndicator extends StatelessWidget {
  const StepsProgressIndicator({
    super.key,
    this.duration = const Duration(milliseconds: 150),
    required this.count,
    required this.index,
  }): assert(index >= 0),
        assert(index <= count);

  final Duration duration;
  final int count;
  final int index;

  @override
  Widget build(
    BuildContext context,
  ) {
    return LinearProgressIndicator(
      value: index / count,
    );
  }
}