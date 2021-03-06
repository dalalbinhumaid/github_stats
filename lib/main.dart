import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:github_stats/Widgets/repository_card.dart';
import 'package:github_stats/models/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:github_stats/models/user.dart';

void main() {
  runApp(const StatsApp());
}

class StatsApp extends StatelessWidget {
  const StatsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Stats App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 40, 43, 51),
      ),
      home: const HomePage(
        title: 'Home Page',
      ),
    );
  }
}

// TODO: - remove to own class
Future<User> fetchUser() async {
  var url = Uri.parse('https://api.github.com/users/dalalbinhumaid');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed");
  }
}

Future<List<Repository>?> fetchTrendingRepos() async {
  final fromDateTimestamp = DateTime.now().subtract(const Duration(days: 14));
  final fromDate = formatDate(fromDateTimestamp, [yyyy, '-', mm, '-', dd]);

  var uri = Uri.http('api.github.com', '/search/repositories', {
    'q': 'created:>$fromDate',
    'sort': 'stars',
    'order': 'desc',
    'page': '0',
    'per_page': '25'
  });

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    return Repository.fromJsonToList((responseBody['items']));
  } else {
    return null;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<User> searchedUser;

  List<Repository> _repositories = [];
  bool _loading = false;
  late String? _error;

  @override
  void initState() {
    super.initState();

    loadTrendingRepositories();
  }

  void loadTrendingRepositories() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final repos = await fetchTrendingRepos();

    setState(() {
      _loading = false;
      if (repos != null) {
        _repositories = repos;
      } else {
        _error = 'error :(';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: trendingList(context),
      ),
    );
  }

  Widget trendingList(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_error != null) {
      return Center(
        child: Text(_error!),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          itemCount: _repositories.length,
          itemBuilder: (BuildContext context, int index) {
            return RepositoryCard(_repositories[index]);
          },
        ),
      );
    }
  }
}
