import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/gpt3.dart';
import '../utils/vision.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          color: const Color.fromARGB(255, 234, 234, 234),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255),
                      offset: Offset.zero,
                      blurRadius: 4.0,
                      spreadRadius: 4.0),
                ],
              ),
              width: 600,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () async {
                          final properties = await getImageProperties();
                          final answer = await getAnswer(properties);
                          print('gpt3 answer');
                          print(answer);
                        },
                        child: const Text('Go to page 2'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
