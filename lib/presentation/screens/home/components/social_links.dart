import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/core/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialNetworkLinks extends StatelessWidget {
  const SocialNetworkLinks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      color: const Color(0xFF24242E),
      child: Row(
        children: [
          const Spacer(),
          IconButton(
            onPressed: () async =>
                await launch('https://www.linkedin.com/in/ma7moud3osman/'),
            icon: SvgPicture.asset("assets/icons/linkedin.svg"),
          ),
          IconButton(
            onPressed: () async =>
                await launch('https://github.com/ma7moud3osman'),
            icon: SvgPicture.asset("assets/icons/github.svg"),
          ),
          IconButton(
            onPressed: () async =>
                await launch('https://twitter.com/MaHmOuD_A_OsMaN'),
            icon: SvgPicture.asset("assets/icons/twitter.svg"),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
