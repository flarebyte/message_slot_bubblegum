import 'package:flutter/material.dart';

import 'circular_parameter_list.dart';

/// A Flutter widget that displays a title and a parameter label from a [CircularParameterList].
/// It also shows a circular progress indicator that represents the current index position relative to the total length.
class CircularParameterWidget<T> extends StatelessWidget {
  final String title;
  final CircularParameterList<T> parameterList;

  const CircularParameterWidget({super.key, required this.title, required this.parameterList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Displays the label of the current parameter in the list.
          Expanded(
            flex: 2,
            child: Text(
              parameterList.current().label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),

          const SizedBox(width: 16.0),

          /// Displays a circular progress indicator representing the index position.
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: CircularProgressIndicator(
                value: parameterList.length() > 0
                    ? (parameterList.currentIndex() + 1) /
                        parameterList.length()
                    : 0.0,
                strokeWidth: 4.0,
              ),
            ),
          ),

          const SizedBox(width: 16.0),

          /// Displays the title of the widget.
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
