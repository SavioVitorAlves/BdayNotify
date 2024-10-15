import 'package:bdaynotify/utils/routes_app.dart';
import 'package:flutter/material.dart';

class ButtonsBar extends StatelessWidget {
  const ButtonsBar(
    this.backgroud1, 
    this.backgroud2,
    this.icon1,
    this.icon2,
    {super.key}
  );
  final Color backgroud1;
  final Color backgroud2;
  final Color icon1;
  final Color icon2;
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name != RoutesApp.HOME) {
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroud1,
              fixedSize: const Size(100,10),
              iconColor: icon1
            ), 
            child: const Icon(Icons.home),
          ),
          ElevatedButton(
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name != RoutesApp.CALENDAR) {
                Navigator.of(context).pushNamed(RoutesApp.CALENDAR);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroud2,
              fixedSize: const Size(100, 10),
              iconColor: icon2,
            ), 
            child: const Icon(Icons.calendar_month),
          ),        
        ],
      ),
    );
  }
}