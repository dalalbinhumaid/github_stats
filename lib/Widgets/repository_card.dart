import 'package:flutter/material.dart';
import 'package:github_stats/models/repository.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryCard extends StatelessWidget {
  final Repository repository;
  const RepositoryCard(this.repository, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 47, 51, 60),
      child: InkWell(
        onTap: () => launchURL(repository.url),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(repository.fullName),
              Text(repository.description ?? "No description available"),
              Row(
                children: [
                  repository.language != null
                      ? Text(repository.language!)
                      : Container(),
                  iconAndData(
                    Icons.star_border_rounded,
                    repository.stargazers,
                  ),
                  iconAndData(
                    Icons.fork_left_rounded,
                    repository.forks,
                  ),
                  iconAndData(
                    Icons.remove_red_eye_rounded,
                    repository.watchers,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  iconAndData(IconData iconData, int data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData),
          Text(data.toString()),
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
