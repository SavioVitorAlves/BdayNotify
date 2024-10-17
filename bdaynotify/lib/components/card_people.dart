import 'package:bdaynotify/models/peoples.dart';
import 'package:flutter/material.dart';

class CardPeople extends StatelessWidget {
  const CardPeople({required this.people, super.key});
  final People people;
  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40
                ),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 15,
                        offset: const Offset(0, 10)
                      )
                    ]
                  ),
                  child: Card(
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
                          height: 50,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color:  Color(0xFF5A6AF1),
                            borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )),
                          child: const Text('10',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(people.name, 
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            Text('10/11/2024', 
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: (){}, 
                          icon: Icon(Icons.check_circle_outline_outlined)
                        )
                      ],
                    ),
                  ),
                ),
              );
  }
}