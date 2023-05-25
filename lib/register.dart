import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr/login.dart';
import 'package:qr/waiter.dart';
import 'verify.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr/start.dart';

import 'colors.dart';

class RegisterView extends StatefulWidget {

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final emailController= TextEditingController();
  final passwordController= TextEditingController();
  final repeatPwdController= TextEditingController();
  bool isVerified=false;
  bool isClicked= false;
  Timer? timer;
@override
 void _startLoading() async {
  if(EmailValidator.validate(emailController.text)&& passwordController.text==repeatPwdController.text &&passwordController.text.length>=6)
    setState(() {
      isClicked = !isClicked;
    });}

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColor(0xff18544b),
        title: Text("Register new user"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient:
                SweepGradient(colors: [Colors.black, getColor(0xff0c1f11)])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) => email != null && !EmailValidator.validate(email)? "Enter a valid email" :null ,
              textInputAction: TextInputAction.next,
              controller: emailController,
            keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                
                filled: true,
                fillColor: getColor(0xff6b9c85),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(width: 3, color: getColor(0xff0a451a))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(width: 3, color: getColor(0xff0a451a))),
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField( controller: passwordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value!= null && value.length<6 ? 
              "Enter min. 6 characters": null,
              textInputAction: TextInputAction.next,
             
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: getColor(0xff6b9c85),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 3, color: getColor(0xff0ac93d)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 3, color: getColor(0xff0a451a)),
                ),
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(controller: repeatPwdController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value!=null   &&value!= passwordController.text?  "Passwords don't match": null,
              
              textInputAction: TextInputAction.next,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  hintText: "Repeat password",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  filled: true,
                  fillColor: getColor(0xff6b9c85),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(width: 3, color: getColor(0xff0a451a))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(width: 3, color: getColor(0xff0a451a)))),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 100,
              width: 0.45 * MediaQuery.of(context).size.width,
              child:isClicked?Center(child: SizedBox(height:0.2 * MediaQuery.of(context).size.width,width:0.2* MediaQuery.of(context).size.width,child: CircularProgressIndicator(strokeWidth: 6.0,))): ElevatedButton(
                  onPressed:(){ checkEmailVerified();
                    _startLoading();register();
                  },
                  style: ElevatedButton.styleFrom(  
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        width: 2,
                        color: getColor(0xff23701d),
                      )
                    ),
                    shadowColor: getColor(0xff278a3c),
                    elevation: 15,
                    backgroundColor: getColor(0xff0a451a),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      letterSpacing: 1.15,
                    ),
                  )),
            ),
            
          ],
        ),
      ),
    );
  }



  Future register() async {
    Timer(const Duration(seconds: 15), () async => await checkEmailVerified());
  

    try{

       if(EmailValidator.validate(emailController.text)&& passwordController.text==repeatPwdController.text &&passwordController.text.length>=6)
      {
         
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
            password: passwordController.text.trim());

             isVerified= FirebaseAuth.instance.currentUser!.emailVerified;
          if(!isVerified){
              final user= FirebaseAuth.instance.currentUser;
              await user!.sendEmailVerification();


                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Verify()),
                              );

                              _startLoading();
          }
          else{print("NISI VERIFIKOVAN");}
          
            
           

          }

    }
    on FirebaseAuthException catch (e){

      _startLoading();
     if (e.code == 'email-already-in-use' && !isVerified) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar
     (
      duration: Duration(seconds: 5),
      backgroundColor: getColor(0xff18544b),
      content: Text("Email already registered, but is not verified. Please verify your email!")));

     }
     else if( e.code == 'email-already-in-use' && isVerified){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginView()));
     }
      
      else{

        ScaffoldMessenger.of(context).showSnackBar(SnackBar
     (
      duration: Duration(seconds: 5),
      backgroundColor: getColor(0xff18544b),
      content: Text(e.code.toString())));
      }
     
    }

    }
    
      
  Future checkEmailVerified() async{

         await FirebaseAuth.instance.currentUser!.reload();
        setState(() {
          isVerified=FirebaseAuth.instance.currentUser!.emailVerified;
        });


     }

      }
