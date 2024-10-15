import 'package:bdaynotify/components/buttons_bar.dart';
import 'package:bdaynotify/utils/routes_app.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> _cores = [
      Color(0xff5A6AF1),
      Color(0x505A6AF1),
      Colors.white,
      Colors.white.withOpacity(0.5),
    ];
    final pageWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('BdayNotify', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF5A6AF1),
        centerTitle: true,
      ),
      body: Container(
        
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5A6AF1),
              Color(0xFF273087)
            ],
            begin: Alignment.topCenter,
            end: Alignment.center
          ),
        ),
        child:  Center(
          child: Column(
            children: [
              SizedBox(height: 5,),
              const Column(
                children: [
                  Text(
                    'BdayNotify',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    'Mant Santa Fé',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14
                    ),
                  )
                ],
              ),
              SizedBox(height: 30,),
              Container(
                padding: const EdgeInsets.only(
                  left: 45,
                  right: 45
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Proximo aniversariante:', 
                      style: TextStyle(
                        fontSize: 13, 
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),
                    Text(
                      'Hoje: 08/11/2024', 
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )
                    )
                  ],
                ),
              ),
              Padding(
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
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nome da Pessoa', 
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                  top: 40
                ),
                height: 500,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFF041F65),
                      Color(0xFF081946)
                    ]
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                  )
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF5A6AF1),
                                Color(0xFF2D378D)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                            ),
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF5A6AF1),
                                Color(0xFF2D378D)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                            ),
                            borderRadius: BorderRadius.circular(10)
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF5A6AF1),
                            Color(0xFF2D378D)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                        ),
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    const SizedBox(height: 45,),
                    ButtonsBar(_cores[0], _cores[1], _cores[2], _cores[3])
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}