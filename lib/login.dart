import 'dart:async';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr/tablePicker.dart';
import 'colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController= TextEditingController();
  final passwordController= TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: getColor(0xff18544b),
        title: Text("Login"),
        

      ),
      body: Container(
       decoration: BoxDecoration(
      gradient: SweepGradient(colors: [Colors.black, getColor(0xff0c1f11)]),
       ),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            textInputAction: TextInputAction.next,
            controller: emailController,
             style: TextStyle(
              letterSpacing: 1.07,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              filled: true,
              fillColor: getColor(0xff6b9c85),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 3, color: getColor(0xff0a451a)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 3, color: getColor(0xff0a451a)),
              ),
              hintText: "Enter your email",
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )
            ),

          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: passwordController,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            autocorrect: false,
            enableSuggestions: false,
            obscureText: true,
            decoration: InputDecoration(
            
              filled: true,
              fillColor: getColor(0xff6b9c85),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 3, color: getColor(0xff0a451a)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 3, color: getColor(0xff0a451a)),
              ),
              hintText: "Enter your password",
              hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )
            ),

          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: 0.6*MediaQuery.of(context).size.width,
            child:  ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 15,
              backgroundColor: getColor(0xff0a451a),
              shadowColor: getColor(0xff278a3c),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 3, color: getColor(0xff23701d)),
                borderRadius: BorderRadius.circular(15),
              )
              
              
            ),
            onPressed: login, child: Text("Login", 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
           letterSpacing: 1.15,

          )
           )),
          ),

         

        ],

       ),
      ),
    );
  }
 
  Future login() async {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), 
    password: passwordController.text.trim());
    final user = FirebaseAuth.instance.currentUser;
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>TablePicker()));
  } 
  
}