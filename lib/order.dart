import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:qr/orderModel.dart';
import 'package:audioplayers/audioplayers.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key, required this.numbers});
  final List<int> numbers;

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final player = AudioPlayer();
  int numberOfOrders = 0;
  List<String> tableNumbers = [];
  List<String> tableOrders = [];
  List<int> tableTime = [];
  final _ordersRef = FirebaseDatabase.instance.ref('Orders');

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of orders"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                  query: _ordersRef.orderByChild('time'),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    /*     int number =
                        int.parse(snapshot.child("number").value.toString());
                        if(tableNumbers.contains(number.toString())==false)
                    tableNumbers.add(number.toString());
                    
                    String order = snapshot.child("order").value.toString();
                    tableOrders.add(order.toString());
                    int time =
                        int.parse(snapshot.child("time").value.toString());
                    tableTime.add(time);
                    print(tableNumbers);
*/
                    if (widget.numbers.contains(
                        int.parse(snapshot.child("number").value.toString()))) {
                      return OrderModel(
                        tableNumber: snapshot.child("number").value.toString(),
                        order: snapshot.child("order").value.toString(),
                        time: (snapshot.child("time").value.toString()),
                        ikona: IconButton(
                          color: Colors.white,
                          iconSize: 40,
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              _ordersRef.child(snapshot.key!).remove(),
                        ),
                      );
                    } else {
                      return const SizedBox(
                        width: 1,
                      );
                    }
                  }))
        ],
      ),
    );
  }
}
