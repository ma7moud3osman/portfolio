import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/core/constants/constants.dart';
import 'package:portfolio/presentation/screens/home/components/social_links.dart';
import 'package:portfolio/presentation/screens/main/components/area_info_text.dart';
import 'package:portfolio/presentation/screens/main/components/coding.dart';
import 'package:portfolio/presentation/screens/main/components/knowledges.dart';
import 'package:portfolio/presentation/screens/main/components/my_info.dart';
import 'package:portfolio/presentation/screens/main/components/skills.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    required Key key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late final ScrollController _controller;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit) {
      _controller = ScrollController();
      _isInit = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const MyInfo(),
            Expanded(
              child: SingleChildScrollView(
                controller: _controller,
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    const AreaInfoText(
                      title: "Residence",
                      text: "Egypt",
                    ),
                    const AreaInfoText(
                      title: "City",
                      text: "Giza",
                    ),
                    const AreaInfoText(
                      title: "Age",
                      text: "25",
                    ),
                    const Skills(),
                    const SizedBox(height: defaultPadding),
                    const Coding(),
                    const Knowledge(),
                    const Divider(),
                    const SizedBox(height: defaultPadding / 2),
                    TextButton(
                      onPressed: () {
                        //TODO: Add CV link here...
                      },
                      child: FittedBox(
                        child: Row(
                          children: [
                            Text(
                              "DOWNLOAD CV",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            ),
                            const SizedBox(width: defaultPadding / 2),
                            SvgPicture.asset("assets/icons/download.svg")
                          ],
                        ),
                      ),
                    ),
                    const SocialNetworkLinks(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
