class Repository {
  String url;
  String fullName;
  String? description;
  String? language;
  int forks;
  int stargazers;
  int watchers;

  Repository(
      {required this.url,
      required this.fullName,
      this.description,
      this.language,
      required this.forks,
      required this.stargazers,
      required this.watchers});

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
        url: json['html_url'],
        fullName: json['full_name'],
        description: json['description'],
        language: json['language'],
        forks: json['forks_count'],
        stargazers: json['stargazers_count'],
        watchers: json['watchers_count']);
  }

  static List<Repository> fromJsonToList(List<dynamic> jsonRepos) {
    List<Repository> repositories = [];
    repositories = jsonRepos.map((r) => Repository.fromJson(r)).toList();

    return repositories;
  }
}
