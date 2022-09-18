import 'package:flutter/material.dart';
import 'package:portfolio/presentation/screens/home/components/heighlights.dart';
import 'package:portfolio/presentation/screens/home/components/home_banner.dart';
import 'package:portfolio/presentation/screens/home/components/my_projects.dart';
import 'package:portfolio/presentation/screens/main/main_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainScreen(
      children: [
        HomeBanner(),
        HighLightsInfo(),
        MyProjects(),
        // Recommendations(),
      ],
    );
  }
}
