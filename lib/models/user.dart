class User {
  String? name;
  String login;
  String avatarURL;
  String htmlURL;
  String? company;
  String? blog;
  String? location;
  String? email;
  String? bio;
  String? twitterUsername;
  int publicRepos;
  int followers;
  int following;
  String createdAt;
  String updatedAt;

  User(
      {this.name,
      required this.login,
      required this.avatarURL,
      required this.htmlURL,
      this.company,
      this.blog,
      this.location,
      this.email,
      this.bio,
      this.twitterUsername,
      required this.publicRepos,
      required this.followers,
      required this.following,
      required this.createdAt,
      required this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      login: json['login'],
      avatarURL: json['avatar_url'],
      htmlURL: json['html_url'],
      company: json['company'],
      blog: json['blog'],
      location: json['location'],
      email: json['email'],
      bio: json['bio'],
      twitterUsername: json['twitter_username'],
      publicRepos: json['public_repos'],
      followers: json['followers'],
      following: json['following'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
