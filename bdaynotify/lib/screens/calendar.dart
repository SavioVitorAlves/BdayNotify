import 'package:bdaynotify/components/buttons_bar.dart';
import 'package:bdaynotify/components/card_month.dart';
import 'package:bdaynotify/models/month_item.dart';
import 'package:bdaynotify/models/months.dart';
import 'package:bdaynotify/utils/routes_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  const Calendar( {super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MonthItem>(context, listen: false).loadMonths();
    });
  }
  @override
  Widget build(BuildContext context) {
    final List _transacoes = [
      'Janeiro',
      'Fevereiro',
      'Março',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
    ];
     final List<Color> _cores = [
      Color(0xff5A6AF1),
      Color(0x505A6AF1),
      Colors.white,
      Colors.white.withOpacity(0.5),
    ];
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Color.fromARGB(255, 63, 79, 219),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            left: 40,
            right: 40,
            top: 40
          ),
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors:[
                Color.fromARGB(255, 63, 79, 219),
                Color(0xFF081946)
              ],
              begin: Alignment.topCenter,
              end: Alignment.center
            )
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              //SizedBox(height: 20,),
              Consumer<MonthItem>(
                builder:(ctx, months, child) {
                  return Container(
                    height: 600,
                    child:  ListView.builder(
                      itemCount: months.monthsCount,
                      itemBuilder: (ctx, i){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          child: CardMonth(month: months.meses[i]),
                          onTap: (){
                            final month = months.meses[i];
                            print(month.runtimeType); // Verifica o tipo em tempo de execução
                            if (month != null) {
                              month.peoples.forEach((person) {
                                print('ID: ${person.id}, Name: ${person.name}');
                              });
                            }
                            if (month is Months) {
                              Navigator.of(context).pushNamed(
                                RoutesApp.MONTH_DETAIL,
                                arguments: month,
                              );
                            } else {
                              print('O item não é do tipo Months');
                            }
                          },
                        ),
                      );
                      }
                    ),
                  );
                }
              ),
              const Spacer(),
              ButtonsBar(_cores[1], _cores[0], _cores[3], _cores[2]),
              const SizedBox(height: 45,),
            ],
          ),
        ),
      ),
    );
  }
}