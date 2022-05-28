import 'package:flutter/material.dart';
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
    print(response.body);
    return User.fromJson(json.decode(response.body));
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
  @override
  @override
  void initState() {
    super.initState();
    fetchUser();
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
