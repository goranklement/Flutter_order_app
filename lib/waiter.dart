import 'package:flutter/material.dart';

class Waiter extends StatefulWidget {
  const Waiter({super.key});

  @override
  State<Waiter> createState() => _WaiterState();
}

class _WaiterState extends State<Waiter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Waiter")),
      body: Column(
        children: [
            Text("Welcome to waiter's part of the app!")

        ],

      ),
    );
  }
}