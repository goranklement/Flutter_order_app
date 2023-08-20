import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'colors.dart';

class QRScanner extends StatelessWidget {
  const QRScanner({
    Key? key,
    required this.cameraController,
    required Animation<double> animation,
  }) : _animation = animation, super(key: key);

  final MobileScannerController cameraController;
  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 400,
          height: 400,
          child: MobileScanner(

              allowDuplicates: false,
              controller: cameraController,
              onDetect: (barcode, args) {
                if (barcode.rawValue == null) {
                  debugPrint('Failed to scan Barcode');
                } else {
                  final String code = barcode.rawValue!;
                  debugPrint('Barcode found! $code');
                  launchUrlString(code);
                }
              }),

              
        ),

        FadeTransition(
    opacity: _animation,
    child: ElevatedButton(onPressed:null, style: ButtonStyle(backgroundColor:MaterialStateProperty.all(getColor(0xff570606)), foregroundColor:MaterialStateProperty.all(Colors.red),), child:  const Text('Scan barcode on the table'),),
      ),
      ],
    );
  }
}
