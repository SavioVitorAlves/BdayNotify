
import 'package:bdaynotify/components/buttons_bar.dart';
import 'package:bdaynotify/components/charts/chart_analytics.dart';
import 'package:bdaynotify/components/charts/chart_aniversariantes.dart';
import 'package:bdaynotify/models/month_item.dart';
import 'package:bdaynotify/models/months.dart';
import 'package:bdaynotify/models/peoples.dart';
import 'package:bdaynotify/utils/routes_app.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int BuscarPessoasDeMes(List<Months> months){
    DateTime now = DateTime.now();
    List<String> monthNames = [
    "janeiro", "fevereiro", "março", "abril", "maio", "junho", 
    "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"
    ];
  
    String currentMonthName = monthNames[now.month - 1];
    
    int total = 0;
    
    for (var mes in months) {
      if (mes.name.toLowerCase() == currentMonthName) {
        total = mes.peoples.length;
      }
    }

    return total;
  }
  
  int PessoasVerify(List<Months> months){
    DateTime now = DateTime.now();
    List<String> monthNames = [
    "janeiro", "fevereiro", "março", "abril", "maio", "junho", 
    "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"
    ];
  
    String currentMonthName = monthNames[now.month - 1];  
    
    int total = 0;
    
    for (var mes in months) {
      if (mes.name.toLowerCase() == currentMonthName) {
        total = peopleCount(mes.peoples);
      }
    }

    return total;
  }
  int peopleCount(List<People> peoples){
      int total = 0;
      for (var person in peoples) {
        if (person.isVerify == true) total++;
      }
      return total; 
  }

  People? proximaPeople(List<Months> months){
    
    DateTime now = DateTime.now();
    List<String> monthNames = [
    "janeiro", "fevereiro", "março", "abril", "maio", "junho", 
    "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"
    ];
  
    String currentMonthName = monthNames[now.month - 1];
   

    for(var mes in months){
      if (mes.name.toLowerCase() == currentMonthName) {
        for (var person in mes.peoples) {
          if (person.date.day >= now.day && person.isVerify == false) {
           return person;
          }
        }
      }
    }
    return null;
  }

  String capitalize(String month) {
  if (month.isEmpty) return month; // Retorna vazio se a string estiver vazia
  return month[0].toUpperCase() + month.substring(1).toLowerCase(); // Capitaliza a primeira letra e coloca o resto em minúsculas
}

  String MesAtal(){
    DateTime now = DateTime.now();
    List<String> monthNames = [
    "janeiro", "fevereiro", "março", "abril", "maio", "junho", 
    "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"
    ];
  
    String currentMonthName = monthNames[now.month - 1];
    return capitalize(currentMonthName);
  }
  
  final Map<int, int> aniversariosPorMes = {
    0: 5,  // Janeiro
    1: 8,  // Fevereiro
    2: 10, // Março
    3: 13, // Abril
    4: 15, // Maio
    5: 9, // Junho
    6: 3, // Julho
    7: 20, // Agosto
    8: 23, // Setembro
    9: 17, // Outubro
    10: 10, // Novembro
    11: 6, // Dezembro
  };

  Map<int, int> geraListaDeAniversariosPorMes(List<Months> meses){
    Map<int, int> aniversarios = {};
    // Lista dos nomes dos meses em ordem
    final List<String> nomesDosMeses = [
      'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 
      'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
    ];

    for (var i = 0; i < 12; i++) {
      //String nomeDoMes = nomesDosMeses[i];

      // Encontra o mês correspondente na lista de meses
      /*final mesData = meses.firstWhere(
        (mes) => mes.name == nomeDoMes,
        orElse: () => Months(id: meses[i].id ,name: nomeDoMes, peoples: []),
      );*/
      

      // Insere o índice do mês e o número de pessoas
      aniversarios[i] = meses[i].peoples.length;
    }
    print(aniversarios);
    return aniversarios;
  }
  
  Map<int, int> pegarIdadedDasPessoas(List<Months> meses){
    Map<int, int> analytics = {};
    int total = 0;
    int adultos = 0;
    int jovens = 0;
    int adolecentes = 0;
    int criancas = 0;
    DateTime now = DateTime.now();
    //navegar por dentro de cada mes
    for(var i = 0; i < 12; i++ ){
      List<People> pessoas = meses[i].peoples;
      //acessar a lista de pessoas de cada mes
      for (var i = 0; i < pessoas.length; i++) {
        //conta a quantidade de pessoas
        total++;
        //verifacar a data de aniversario de cada pessoa
        int idade = now.year - pessoas[i].date.year;
        //verificar se é adulto
        if (idade >=22){
          adultos++;
        }
        //verifica se é jovem
        else if(idade < 22 && idade >=16){
          jovens++;
        }
        //verifica se é adolecente
        else if(idade < 16 && idade >= 11){
          adolecentes++;
        }
        //caso nao seje nem uma das opçoes acima 
        else{
          criancas++;
        }
      }
    }
    // adicionar a lista os totais
    analytics[0] = total;
    analytics[1] = adultos;
    analytics[2] = jovens;
    analytics[3] = adolecentes;
    analytics[4] = criancas;
    
    return analytics;
  }

   bool _isLoading = true; // Controle de carregamento
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MonthItem>(context, listen: false).loadMonths().then((_){

        setState(() {
          _isLoading = false;
        });
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final List<Color> _cores = [
      const Color(0xff5A6AF1),
      const Color(0x505A6AF1),
      Colors.white,
      Colors.white.withOpacity(0.5),
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('BdayNotify', 
        style: TextStyle(
          fontSize: 40,
          color: Colors.white, 
          fontWeight: FontWeight.normal,
          fontFamily: 'Karantina'
        )
      ),
        backgroundColor: const Color(0xFF5A6AF1),
        centerTitle: true,
      ),
      body: Consumer<MonthItem>(
        builder: (context, month, child){
          // Verifica se os dados do mês estão carregados
          if (month.meses == null || month.meses.isEmpty) {
            // Se os dados não estão carregados, exibe o CircularProgressIndicator
            return const Center(child: CircularProgressIndicator());
          }

          // Se os dados estão carregados, prossegue para buscar a próxima pessoa
          People? proximaPessoa = proximaPeople(month.meses);
  
          return Container(
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
                  const SizedBox(height: 30,),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 45,
                      right: 45
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Proximo aniversariante:', 
                          style: TextStyle(
                            
                            fontSize: 13, 
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'KoHo'
                          )
                        ),
                        Text(
                          'Hoje: ${DateFormat('dd/MM/y').format(DateTime.now())}', 
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'KoHo'
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
                      child: proximaPessoa != null 
                          ? GestureDetector(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Color(0x40B7BBC8),
                                    width: 1
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                
                                color: const Color(0x60081946),
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
                                      child:  Text(DateFormat('dd').format(proximaPessoa.date),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontFamily: 'Karantina'
                                      ),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(proximaPessoa.name, 
                                          style: const TextStyle(
                                            fontSize: 25,
                                            height: 0.9,
                                            color: Colors.white,
                                            fontFamily: 'Karantina',
                                            letterSpacing: 2
                                          ),
                                        ),
                                        Text(DateFormat('dd/MM/y').format(proximaPessoa.date), 
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            height: 0.9,
                                            letterSpacing: 1,
                                            fontFamily: 'Karantina',
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                            ),
                            onTap: (){
                              DateTime now = DateTime.now();
                              Navigator.of(context).pushNamed(
                                  RoutesApp.MONTH_DETAIL,
                                  arguments: month.meses[now.month - 1],
                              );
                            }
                          )
                          : const Center(
                              child: Text(
                                'Todas as Pessoas do mes Atual já foram Verificadas!',
                                style: TextStyle(color: Colors.white, fontFamily: 'Karantina'),
                              )
                            ),
                      
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                      top: 60
                    ),
                    height: 600,
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
                                  height: 140,
                                  width: 140,
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
                                  padding: EdgeInsets.all(5),
                                  child: Center(
                                    child: Text(
                                      MesAtal(),
                                      style: const TextStyle(
                                        fontSize: 50,
                                        height: .8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'KoHo'
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 140,
                                  width: 140,
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
                                  
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              PessoasVerify(month.meses).toString(),
                                              style: const TextStyle(
                                                fontSize: 90,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontFamily: 'Karantina',
                                                height: 0.9
                                              ),
                                            ),
                                            Text(
                                              '/${BuscarPessoasDeMes(month.meses).toString()}',
                                              style: const TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                
                                                fontFamily: 'Karantina',
                                              ),
                                              
                                            )
                                          ],
                                        )
                                      ),
                                    
                                )
                              ],
                            ),
                            const SizedBox(height: 10,),
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
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5,),
                                  child: SizedBox.expand(
                                    child: PageView(
                                      children: [
                                        ChartAnivesariantes(aniversariosPorMes: geraListaDeAniversariosPorMes(month.meses)),
                                        ChartAnalytics(data: pegarIdadedDasPessoas(month.meses),),
                                      ],
                                    )
                                  ),
                                )),
                            ),
                            const Spacer(),
                            ButtonsBar(_cores[0], _cores[1], _cores[2], _cores[3]),
                            const SizedBox(height: 45,),
                          ],
                        ),
                    
                  )
                ],
              ),
              
            )
        );
        },
        
      ),
    );
  }
}