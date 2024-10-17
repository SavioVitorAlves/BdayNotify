import 'package:bdaynotify/components/card_people.dart';
import 'package:bdaynotify/models/month_item.dart';
import 'package:bdaynotify/models/months.dart';
import 'package:flutter/material.dart';

class MonthDetailScreem extends StatelessWidget {
  const MonthDetailScreem({super.key});

  @override
  Widget build(BuildContext context) {
    final Months mes = ModalRoute.of(context)!.settings.arguments as Months;
    return  Scaffold(
      appBar: AppBar(
        title: Text(mes.name),
        centerTitle: true,
        backgroundColor: Color(0xFF2D378D),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(
              Icons.more_vert, 
              color: Colors.white,
            )
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2D378D),
              Color(0xFF5A6AF1)
            ],
            begin: Alignment.topCenter,
            end: Alignment.center
          ),
        ),
        child: Container(
          child: ListView.builder(
            itemCount: mes.peoples.length,
            itemBuilder: (ctx, i) => CardPeople(people: mes.peoples[i])
          ),
        ),
      )
    );
  }
}