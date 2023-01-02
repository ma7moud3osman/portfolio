import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/constants.dart';
import 'package:portfolio/presentation/widgets/animated_progress_indicator.dart';

class Coding extends StatelessWidget {
  const Coding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Text(
            "Coding",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        const AnimatedLinearProgressIndicator(
          percentage: 0.80,
          label: "Dart",
        ),
        const AnimatedLinearProgressIndicator(
          percentage: 0.55,
          label: "Java",
        ),
        const AnimatedLinearProgressIndicator(
          percentage: 0.55,
          label: "Kotlin",
        ),
        const AnimatedLinearProgressIndicator(
          percentage: 0.50,
          label: "C++",
        ),
        // const AnimatedLinearProgressIndicator(
        //   percentage: 0.58,
        //   label: "JavaScript",
        // ),
      ],
    );
  }
}
