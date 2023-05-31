import 'package:flutter/material.dart';
import 'package:samaritan/widgets/postcard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 92, 91, 140),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const <Widget>[
              PostCard(destination: 'People \nFor Animals', distance: '10m'),
              PostCard(destination: 'Red Cross', distance: '10m'),
              PostCard(destination: 'United Nations', distance: '10m'),
              PostCard(destination: 'Literary Club', distance: '10m'),
              PostCard(destination: 'Goodwill', distance: '10m'),
              PostCard(destination: 'H&M', distance: '10m'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        elevation: 0,
        backgroundColor: const Color.fromRGBO(146, 143, 221, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
