import 'package:flutter/material.dart';

import 'circular_parameter_list.dart';

/// A Flutter widget that displays a title and a parameter label from a [CircularParameterList].
/// It also shows a circular progress indicator that represents the current index position relative to the total length.
class CircularParameterWidget<T> extends StatelessWidget {
  final String title;
  final CircularParameterList<T> parameterList;

  CircularParameterWidget({super.key, required this.title, required this.parameterList});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /// Displays the title of the widget.
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8.0),

        /// Displays the label of the current parameter in the list.
        Text(
          parameterList.current().label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(width: 16.0),

        /// Displays a circular progress indicator representing the index position.
        CircularProgressIndicator(
          value: parameterList.length() > 0
              ? (parameterList.currentIndex() + 1) / parameterList.length()
              : 0.0,
          strokeWidth: 4.0,
        ),
      ],
    );
  }
}
