import 'package:figma_squircle/figma_squircle.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:github_stats/models/repository.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryCard extends StatelessWidget {
  final Repository repository;
  const RepositoryCard(this.repository, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => launchURL(repository.url),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: ShapeDecoration(
            color: const Color.fromARGB(255, 47, 51, 60),
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 20,
                cornerSmoothing: 0.8,
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameAndShare(repository.fullName),
                Text(
                  repository.description ?? "No description available",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 0.9,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 196, 196, 196),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      repository.language != null
                          ? languageAndColor(repository.language!)
                          : Container(),
                      const Spacer(),
                      iconAndData(
                        FluentIcons.star_16_regular,
                        repository.stargazers,
                      ),
                      iconAndData(
                        FluentIcons.branch_fork_16_regular,
                        repository.forks,
                      ),
                      iconAndData(
                        FluentIcons.eye_16_regular,
                        repository.watchers,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  nameAndShare(String fullName) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              repository.fullName,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          ),
          const Icon(
            FluentIcons.open_16_regular,
            color: Color.fromRGBO(203, 204, 196, 0.4),
            size: 16,
          ),
        ],
      ),
    );
  }

  languageAndColor(String language) {
    Color languageColor = generateColor(language);

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6.0,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
              color: languageColor,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: languageColor.withOpacity(0.7),
                  spreadRadius: 1.0,
                  blurRadius: 3.0,
                )
              ]),
        ),
        Text(
          language,
          textScaleFactor: 0.9,
          style: const TextStyle(
            color: Color.fromARGB(255, 196, 196, 196),
          ),
        )
      ],
    );
  }

  iconAndData(IconData iconData, int data) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 4.0,
        children: [
          Icon(
            iconData,
            size: 16.0,
            color: const Color.fromARGB(255, 196, 196, 196),
          ),
          Text(
            data.toString(),
            textScaleFactor: 0.9,
            style: const TextStyle(
              color: Color.fromARGB(255, 196, 196, 196),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}

// TODO: Move to repository class
Color generateColor(String language) {
  if (language[1] == '+') return Color.fromARGB(255, 228, 44, 148);
  if (language[1] == '#') return Color.fromARGB(255, 31, 172, 36);
  if (language[0] == 'A') return Color.fromARGB(255, 0, 9, 179);
  if (language[0] == 'B') return Color.fromARGB(255, 228, 231, 19);
  if (language[0] == 'C') return Color.fromARGB(255, 137, 136, 138);
  if (language[0] == 'D') return Color.fromARGB(255, 0, 242, 255);
  if (language[0] == 'E') return Color.fromARGB(255, 255, 0, 247);
  if (language[0] == 'G') return Color.fromARGB(255, 80, 30, 197);
  if (language[0] == 'H') return Color.fromARGB(255, 255, 94, 19);
  if (language[0] == 'J' && language[4] == 'S')
    return Color.fromARGB(255, 229, 223, 120);
  if (language[0] == 'J') return Color.fromARGB(255, 219, 153, 23);
  if (language[0] == 'K') return Color.fromARGB(255, 181, 108, 255);
  if (language[0] == 'P' && language[1] == 'H')
    return Color.fromARGB(255, 146, 41, 246);
  if (language[0] == 'P') return Color.fromARGB(255, 6, 98, 189);
  if (language[0] == 'R') return Color.fromARGB(255, 191, 46, 46);
  if (language[1] == 'm') return Color.fromARGB(255, 251, 167, 41);
  if (language[0] == 'S') return Color.fromARGB(255, 251, 97, 41);
  if (language[0] == 'T') return Color.fromARGB(255, 68, 99, 190);

  return Color.fromARGB(255, 37, 234, 194);
}
