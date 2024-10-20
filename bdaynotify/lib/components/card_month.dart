import 'package:bdaynotify/models/month_item.dart';
import 'package:bdaynotify/models/months.dart';
import 'package:flutter/material.dart';


class CardMonth extends StatelessWidget {
  const CardMonth({ required this.month, super.key});
  final Months month;
  @override
  Widget build(BuildContext context) {
    
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Color(0x807F97EE),
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        Container(
          //width: 270,
          child:  Center(
            child: Text(
              month.name.toString(), 
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30
              ),
            ),
          ),
        ),
        //Spacer(),
        Positioned(
          left: 370,
          top: 43,
          child: Container(
            transformAlignment: Alignment.bottomLeft,
            width: 25,
            //height: 20,
            child: const Row(
              children: [
                Text('6',style: TextStyle(color: Colors.white, fontSize: 10),),
                Text('/15',style: TextStyle(color: Colors.white, fontSize: 10),)
              ],
            ),
          ),
        ),      
      ],
    );
  }
}