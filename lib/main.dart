import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr/start.dart';
import 'colors.dart';
import 'QRScanner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(MaterialApp(
      title: 'QR Scanner',
      home:  StartView(),
    ));
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    lowerBound: 0.3,
    duration: const Duration(seconds: 30),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  MobileScannerController cameraController = MobileScannerController();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: getColor(0xff18544b),
          title: const Text('Mobile Scanner'),
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state) {
                    case TorchState.off:
                      return const Icon(Icons.no_flash, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flashlight_on, color: Colors.yellow);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state) {
                    case CameraFacing.front:
                      return const Icon(Icons.flip_camera_ios);
                    case CameraFacing.back:
                      return const Icon(Icons.flip_camera_ios);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.switchCamera(),
            ),
          ],
        ),
        body: QRScanner(cameraController: cameraController, animation: _animation));
  }
}

