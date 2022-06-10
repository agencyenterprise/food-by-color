import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnswerPage extends StatelessWidget {
  const AnswerPage({Key? key, required this.title}) : super(key: key);
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
                        onPressed: () => context.go('/'),
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
