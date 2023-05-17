import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'screen/home_screen.dart';

late List<CameraDescription> _cameras;
void main() {
  runApp(MaterialApp(home: HomeScreen()));
}

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();

    initializeCamera();
  }

  initializeCamera() async {
    try {
      controller = CameraController(_cameras[0], ResolutionPreset.max);

      await controller.initialize();

      setState(() {});
    } catch (e) {
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
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(controller),
    );
  }
}
