import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/constants.dart';
import 'package:portfolio/data/models/project.dart';

class ProjectProfileImageView extends StatelessWidget {
  final Project project;
  const ProjectProfileImageView({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Center(
          child: CachedNetworkImage(
            imageUrl: project.cover!,
            width: min(maxWidth, MediaQuery.of(context).size.width * 2) / 2,
            height:
                min(maxWidth, MediaQuery.of(context).size.width * 2.2) / 4.5,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: -defaultPadding * 3,
          child: Hero(
            tag: project.icon!,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultPadding * 2),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 6,
                      spreadRadius: 2,
                      color: Colors.black26,
                    )
                  ]),
              child: CachedNetworkImage(
                imageUrl: project.icon!,
                width: 120,
                height: 120,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
