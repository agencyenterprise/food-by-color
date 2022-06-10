import 'package:flutter/material.dart';
import 'package:food_by_color/controllers/application_controller/application_controller_state.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/application_controller/application_controller_bloc.dart';
import '../utils/gpt3.dart';
import '../utils/vision.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ApplicationControllerBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ApplicationControllerBloc>();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
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
                  child: BlocBuilder<ApplicationControllerBloc,
                      ApplicationControllerState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (state is ApplicationControllerStateLoaded)
                            Image.network(state.imagePath)
                          else
                            Container(),
                          ElevatedButton(
                            onPressed: () async {
                              context.go('/camera');
                              // final properties = await getImageProperties();
                              // final answer = await getAnswer(properties);
                              // print('gpt3 answer');
                              // print(answer);
                            },
                            child:
                                const Text('Take a picture of my food plate'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
