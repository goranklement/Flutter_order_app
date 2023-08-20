import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'colors.dart';

class OrderModel extends StatefulWidget {
  const OrderModel(
      {super.key,
      required this.tableNumber,
      required this.order,
      required this.ikona,
      required this.time});
  final String tableNumber;
  final String order;
  final IconButton ikona;
  final String time;

  @override
  State<OrderModel> createState() => _OrderModelState();
}

class _OrderModelState extends State<OrderModel>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Call setState to trigger a rebuild every second
      setState(() {});
    });
  }

  String calculateElapsedTime(int time) {
    int current = DateTime.now().millisecondsSinceEpoch;
    int seconds = ((current - time) ~/ 1000);
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    String elapsedTime = calculateElapsedTime(int.parse(widget.time));
    return Container(
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: getColorFromTime(elapsedTime),
          borderRadius: BorderRadius.circular(30)),
      child: InkWell(
        onDoubleTap: () {},
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(widget.tableNumber.toString(),
              style: TextStyle(
                color: getColor(0xff716575),
                fontWeight: FontWeight.bold,
                fontSize: 40,
              )),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(widget.order.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                )),
          ),
          Text(elapsedTime,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              )),
          widget.ikona,
        ]),
      ),
    );
  }

  getColorFromTime(String time) {
    List<String> timeParts = time.split(':');
    int minutes = int.parse(timeParts[0]);
    int seconds = int.parse(timeParts[1]);

    Duration elapsedTime = Duration(minutes: minutes, seconds: seconds);

    Duration remainingTime = const Duration(minutes: 10) - elapsedTime;
    if (remainingTime.isNegative) {
      remainingTime = Duration();
    }
    double remainingPercentage =
        remainingTime.inSeconds / const Duration(minutes: 10).inSeconds;

    int red = (200 * (1 - remainingPercentage)).toInt();
    int green = (200 * remainingPercentage).toInt();

    return Color.fromRGBO(red, green, 0, 1);
  }
}
