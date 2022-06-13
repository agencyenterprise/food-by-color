import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  Widget _colorPallet(colors) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          const SizedBox(
            width: 300,
            child: Text(
              'Color pallet of your plate:',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 77, 77, 77),
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: List.from(
              (colors as List).map(
                (item) {
                  var color = item['color'];
                  return SizedBox(
                    width: 40,
                    height: 200,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                          color['red'] ?? 0,
                          color['blue'] ?? 0,
                          color['green'] ?? 0,
                          90,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadedImageWidgets(state) {
    final colors = (state.properties['responses'][0]
            ['imagePropertiesAnnotation']['dominantColors']['colors'] as List)
        .toList();
    print(colors);
    return Column(
      children: [
        const Text(
          'Answer',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 77, 77, 77),
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            state.answer,
            style: const TextStyle(
              color: Color.fromARGB(255, 77, 77, 77),
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 45),
        _colorPallet(colors),
        const SizedBox(height: 45),
        const SizedBox(
          width: 300,
          child: Text(
            'Your plate:',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 77, 77, 77),
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 300,
          child: Image.memory(
            base64Decode(state.imagePath),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.title)),
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
                            _loadedImageWidgets(state)
                          else
                            Container(),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              context.go('/camera');
                            },
                            child: const Text(
                              'Take a picture of my food plate',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
