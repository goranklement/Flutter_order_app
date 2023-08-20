import 'package:flutter/material.dart';
import 'package:qr/login.dart';
import 'package:qr/main.dart';
import 'package:qr/register.dart';
import 'colors.dart';

class StartView extends StatelessWidget {
  StartView({super.key});
  String title = "QR Order";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: getColor(0xff18544b),
          title: const Text('Mobile Scanner'),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient:
                  SweepGradient(colors: [Colors.black, getColor(0xff0c1f11)])),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 0.6 * MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: getColor(0xff278a3c),
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        foregroundColor: getColor(0xff82ff9d),
                        backgroundColor: getColor(0xff345e3a)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterView()),
                      );
                    },
                    child: const Text("Register")),
              ),
              const SizedBox(height: 20),
              SizedBox(
                  width: 0.6 * MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()));
                      },
                      style: ElevatedButton.styleFrom(
                          shadowColor: getColor(0xff278a3c),
                          foregroundColor: getColor(0xff82ff9d),
                          backgroundColor: getColor(0xff345e3a),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          )),
                      child: const Text("Login"))),
              const SizedBox(height: 20),
              SizedBox(
                width: 0.6 * MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: getColor(0xff262626),
                        foregroundColor: getColor(0xff82ff9d),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                  title: title,
                                )),
                      );
                    },
                    child: const Text("Continue as a guest")),
              )
            ],
          ),
        ));
  }
}
