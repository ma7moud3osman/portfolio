import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/constants.dart';
import 'package:portfolio/core/constants/responsive.dart';
import 'package:portfolio/data/models/project.dart';
import 'package:portfolio/presentation/screens/projectDetails/project_details_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key? key,
    required this.onTap,
    required this.project,
  }) : super(key: key);

  final Project project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive.isMobile(context)
          ? const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 4,
                  vertical: defaultPadding / 1.5)
              .copyWith(bottom: 0)
          : const EdgeInsets.all(defaultPadding),
      color: secondaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: Text(
              project.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const Spacer(),
          Center(
            child: Hero(
              tag: project.icon!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    Responsive.isDesktop(context)
                        ? defaultPadding * 4
                        : defaultPadding * 1.2),
                child: CachedNetworkImage(
                  imageUrl: project.icon!,
                  width:
                      0.23 * min(maxWidth, MediaQuery.of(context).size.width),
                  height:
                      0.23 * min(maxWidth, MediaQuery.of(context).size.width),
                ),
              ),
            ),
          ),
          if (Responsive.isDesktop(context)) ...[
            const Spacer(),
            Text(
              project.shortDescription!,
              maxLines: Responsive.isTablet(context) ? 1 : 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(height: 1.5, fontSize: 18),
            ),
          ],
          const Spacer(),
          Row(
            children: [
              if (project.url != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(defaultPadding * 4),
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
                  borderRadius: BorderRadius.circular(defaultPadding * 4),
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () async => await launch(project.iosUrl!),
                      padding: const EdgeInsets.all(12),
                      icon: Image.asset(
                        'assets/images/app_store_icon.png',
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProjectDetailsScreen(
                        project: project,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Read More >>",
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
