import 'dart:ui';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: <Widget>[
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 50),
            child: Image.asset(
              'assets/images/tomato.png',
            ),
          ),
           BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: const Color.fromRGBO(224, 95, 82, 0.6)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: TextButton(
                  child: const Text('New Session'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/new-session');
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: TextButton(
                  child: const Text('New Task'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/new-task');
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: TextButton(
                  child: const Text('History'),
                  onPressed: () {},
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: TextButton(
                  child: const Text('Settings'),
                  onPressed: () {},
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: TextButton(
                  child: const Text('WidgetTesting'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/widget-testing');
                  },
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
