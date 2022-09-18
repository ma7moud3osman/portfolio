import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/constants.dart';
import 'package:portfolio/data/models/project.dart';
import 'package:portfolio/presentation/screens/projectDetails/components/image_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final Project project;
  const ProjectDetailsScreen({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProjectProfileImageView(project: project),
            Container(
              width: maxWidth / 2,
              padding: const EdgeInsets.all(defaultPadding * 4),
              child: Column(
                children: [
                  Text(
                    project.title!,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    project.shortDescription!,
                    style: const TextStyle(height: 1.5, fontSize: 18),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    project.description!,
                    style: const TextStyle(height: 1.5, fontSize: 16),
                  ),
                  const SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (project.url != null)
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(defaultPadding * 4),
                          child: Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () async => await launch(project.url!),
                              padding: const EdgeInsets.all(12),
                              icon: Image.asset(
                                'assets/images/google_play_icon.png',
                              ),
                            ),
                          ),
                        ),
                      if (project.iosUrl != null)
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(defaultPadding * 4),
                          child: Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () async =>
                                  await launch(project.iosUrl!),
                              padding: const EdgeInsets.all(12),
                              icon: Image.asset(
                                'assets/images/app_store_icon.png',
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
