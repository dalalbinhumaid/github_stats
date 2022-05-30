import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:github_stats/models/repositry.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(
        title: 'Home Page',
      ),
    );
  }
}

Future<User> fetchUser() async {
  var url = Uri.parse('https://api.github.com/users/dalalbinhumaid');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed");
  }
}

Future<List<Repository>> fetchTrendingRepos() async {
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
    throw Exception("Failed");
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

  @override
  void initState() {
    super.initState();
    fetchUser();
    fetchTrendingRepos();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
