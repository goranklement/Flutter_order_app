import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'colors.dart';

class OrderModel extends StatefulWidget {
  const OrderModel({super.key, required this.tableNumber, required this.order,  required this.ikona, required this.time});
  final String tableNumber;
  final String order;
  final IconButton ikona;
  final String time;

  @override
  State<OrderModel> createState() => _OrderModelState();
  
}


class _OrderModelState extends State<OrderModel> with SingleTickerProviderStateMixin {
   late AnimationController _animationController;
  late Animation _animation;
  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(minutes: 10));

    _animation = ColorTween(begin: getColor(0xff51b06d), end: getColor(0xffe80909))
        .animate(CurvedAnimation(
            curve: Curves.decelerate, parent: _animationController))
          ..addListener(() {
            setState(() {});
          });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.repeat(max: 1);
        _animationController.forward();
      }
    });
    _animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(minutes: 10),
      margin: EdgeInsets.all(7),
     padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _animation.value,
        borderRadius: BorderRadius.circular(30)
      ),
        child: InkWell(
          onDoubleTap: (){print("deleted");},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(widget.tableNumber.toString(), style: TextStyle(
              color: getColor(0xff716575),
              fontWeight: FontWeight.bold,
              fontSize: 40,
            )),
            SizedBox(width: 15,),
            Expanded(
              child: Text(widget.order.toString(),style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            )),
            ),
            Text(widget.time,style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            )),
            widget.ikona,]
          ),
        ),
    );
  }
}