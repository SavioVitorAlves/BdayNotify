import 'package:bdaynotify/models/peoples.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CardPeople extends StatelessWidget {
  const CardPeople({ required this.mesId, required this.people, super.key});
  final People people;
  final String mesId;
  
  @override
  Widget build(BuildContext context) {
    
    //final pessoa = Provider.of<People>(context, listen: false);
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 10)
          )
        ]
      ),
      child: Card(
        /*margin: EdgeInsets.only(
          bottom: 10
        ),*/
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color(0x40B7BBC8),
            width: 1
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        
        color: Color(0x60081946),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 70,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color:  Color(0xFF5A6AF1),
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )),
              child:  Text(DateFormat('dd').format(people.date),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w400,
                fontFamily: 'Karantina',
              ),
              ),
            ),
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(people.name, 
                  style: const TextStyle(
                    fontSize: 25,
                    height: 0.9,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: 'Karantina',
                  ),
                ),
                Text(DateFormat('dd/MM/y').format(people.date), 
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    height: 0.9,
                    fontFamily: 'Karantina',
                    fontWeight: FontWeight.w300
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              padding: const EdgeInsets.only(right: 5),
              onPressed: () async{
                await people.toggleVerify(mesId, people.id);
                (context as Element).markNeedsBuild(); 
              }, 
              icon: people.isVerify ? const Icon(Icons.check_circle, color: Colors.white,) : const Icon(Icons.check_circle_outline_outlined, color: Colors.white)
            )
          ],
        ),
      ),
    );
  }
}