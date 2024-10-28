import 'package:bdaynotify/models/month_item.dart';
import 'package:bdaynotify/models/months.dart';
import 'package:bdaynotify/models/peoples.dart';
import 'package:flutter/material.dart';


class CardMonth extends StatelessWidget {
  const CardMonth({ required this.month, super.key});
  final Months month;
  
  int peopleCount(List<People> peoples){
      int total = 0;
      peoples.forEach((person) {
        if (person.isVerify == true) total++;
      });
      return total; 
  }
  
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
                fontSize: 30,
                fontFamily: 'KoHo',
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        //Spacer(),
        Positioned(
          left: 280,
          top: 37,
          child: Container(
            transformAlignment: Alignment.bottomLeft,
            width: 25,
            //height: 20,
            child: Row(
              children: [
                Text(peopleCount(month.peoples).toString(),style: const TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'KoHo',),),
                Text('/${month.peoples.length}',style: const TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'KoHo',),)
              ],
            ),
          ),
        ),      
      ],
    );
  }
}