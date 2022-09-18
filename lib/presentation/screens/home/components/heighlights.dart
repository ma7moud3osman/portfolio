import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/constants.dart';
import 'package:portfolio/core/constants/responsive.dart';
import 'package:portfolio/data/models/project.dart';
import 'package:portfolio/presentation/widgets/animated_counter.dart';

import 'heigh_light.dart';

class HighLightsInfo extends StatelessWidget {
  const HighLightsInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: defaultPadding, horizontal: defaultPadding),
      child: !Responsive.isDesktop(context)
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HeighLight(
                      counter: AnimatedCounter(
                        value: myAllProjects.length,
                        text: 'Apps',
                      ),
                      label: "Total",
                    ),
                    const HeighLight(
                      counter: AnimatedCounter(
                        value: 8,
                        text: "Apps",
                      ),
                      label: "Android (Play Store)",
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    HeighLight(
                      counter: AnimatedCounter(
                        value: 4,
                        text: "Apps",
                      ),
                      label: "IOS (App Store)",
                    ),
                    HeighLight(
                      counter: AnimatedCounter(
                        value: 1,
                        text: "+",
                      ),
                      label: "GitHub Projects",
                    ),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HeighLight(
                  counter: AnimatedCounter(
                    value: myAllProjects.length,
                    text: 'Apps',
                  ),
                  label: "Total",
                ),
                const HeighLight(
                  counter: AnimatedCounter(
                    value: 8,
                    text: "Apps",
                  ),
                  label: "Android (Play Store)",
                ),
                const HeighLight(
                  counter: AnimatedCounter(
                    value: 4,
                    text: "Apps",
                  ),
                  label: "IOS (App Store)",
                ),
                const HeighLight(
                  counter: AnimatedCounter(
                    value: 1,
                    text: "+",
                  ),
                  label: "GitHub Projects",
                ),
              ],
            ),
    );
  }
}
