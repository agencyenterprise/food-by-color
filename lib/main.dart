import 'package:flutter/material.dart';
import 'package:food_by_color/pages/answer.dart';
import 'package:food_by_color/pages/camera.dart';
import 'package:food_by_color/pages/home.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  static const String title = 'Food by color';
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: title,
      );

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(title: title),
      ),
      GoRoute(
        path: '/camera',
        builder: (BuildContext context, GoRouterState state) =>
            const CameraPage(title: title),
      ),
      GoRoute(
        path: '/answer',
        builder: (BuildContext context, GoRouterState state) =>
            const AnswerPage(
          title: title,
        ),
      ),
    ],
  );
}
