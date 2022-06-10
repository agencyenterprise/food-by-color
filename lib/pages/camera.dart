import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:camera/camera.dart';

import '../controllers/application_controller/application_controller_bloc.dart';
import '../controllers/application_controller/application_controller_events.dart';
import '../utils/gpt3.dart';
import '../utils/vision.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _loading = false;
  late ApplicationControllerBloc _bloc;
  late List<CameraDescription> _cameras;
  late CameraController controller;
  bool _cameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ApplicationControllerBloc>();
    _getCameras();
  }

  Future<void> _getCameras() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _cameraInitialized = true;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    }
  }

  Widget _mainWidget() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: Colors.grey,
                width: 3.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Center(
                child: CameraPreview(controller),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _captureControlRowWidget(),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _captureControlRowWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
                icon: const Icon(Icons.fiber_manual_record_outlined),
                color: Colors.blue,
                onPressed: () async {
                  final XFile image = await controller.takePicture();
                  final bytes = await image.readAsBytes();

                  final base64image = base64Encode(bytes);
                  setState(() {
                    _loading = true;
                  });
                  final properties = await getImageProperties(base64image);
                  final answer = await getAnswer(properties);
                  _bloc.add(
                    ApplicationControllerEventsLoad(
                      imagePath: base64image,
                      answer: answer,
                    ),
                  );
                  setState(() {
                    _loading = false;
                  });
                  context.go('/');
                }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (context) {
          if (!_cameraInitialized || _loading) {
            return Center(
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      "Calculating...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 77, 77, 77),
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 100,
                    child: CircularProgressIndicator(
                      color: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
            );
          }
          return _mainWidget();
        },
      ));
}
