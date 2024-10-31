import 'dart:convert';

import 'dart:math';

import 'package:bdaynotify/exceptions/http_exceptions.dart';
import 'package:bdaynotify/main.dart';
import 'package:bdaynotify/models/months.dart';
import 'package:bdaynotify/models/peoples.dart';
import 'package:bdaynotify/utils/db_routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MonthItem with ChangeNotifier{
  List<Months> _meses = [];

  List<Months> get meses {
    return [..._meses];
  }

  MonthItem([this._meses = const []]);

 
  
    
  int get monthsCount{
    return _meses.length;
  }

  get body => null;


  Future<void> loadMonths() async{
    final response = await http.get(Uri.parse('${DbRoutes.MESES_BASE_URL}.json'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    List<Months> itens = [];

    data.forEach((monthId, monthData){
      List<People> peoplesList = [];

      // Verifica se `peoples` é um objeto ou uma lista
      if (monthData['peoples'] is Map<String, dynamic>) {
        // Se for um objeto, percorre as chaves e cria a lista de People
        (monthData['peoples'] as Map<String, dynamic>).forEach((key, value) {
          peoplesList.add(
            People(
              id: key, 
              name: value['name'], 
              date: DateTime.parse(value['date']),
              isVerify: value['isVerify'],
            )
          );
        });
      } else if (monthData['peoples'] is List<dynamic>) {
        // Se for uma lista, mapeia normalmente
        peoplesList = (monthData['peoples'] as List<dynamic>).map((item) {
          return People(
            id: item['id'], 
            name: item['name'], 
            date: DateTime.parse(item['date']),
            isVerify: item['isVerify'],
          );
        }).toList();
      }
      peoplesList.sort((a, b) => a.date.compareTo(b.date));
      itens.add(
        Months(
          id: monthId, 
          name: monthData['name'], 
          peoples: peoplesList,
        )
      );

    });
    print('Loaded months: ${itens.map((m) => m.peoples).toList()}');
    _meses = itens.toList();
    notifyListeners();
  }
  

  Future<void> savePeople(Map<String, dynamic> data, String mesId) async{

    final pessoa = People(
      id: Random().nextDouble().toString(), 
      name: data['name'] as String, 
      date: data['date'] as DateTime,
      //isVerify: false
    ); 
    
     await addPeople(pessoa, mesId);
    
  }
  Future<void> save(Map<String, dynamic> data, String mesId, String peopleId) async{

    final pessoa = People(
      id: peopleId, 
      name: data['name'] as String, 
      date: data['date'] as DateTime,
      //isVerify: false
    ); 
    
     await updatePeople(pessoa, mesId);
    
  }
  
  Future<void> addMonth(Months months) async{
    await http.post(
      Uri.parse('${DbRoutes.MESES_BASE_URL}.json'),
      body: jsonEncode(
        {
          'id': months.id,
          'name': months.name,
          'peoples': months.peoples.map((person) => person.toJson()).toList(),
        }
      )
    );
    notifyListeners();
  }
  
  Future<void> addPeople(People people, String mesId) async{
    await http.post(
      Uri.parse('${DbRoutes.MESES_BASE_URL}/$mesId/peoples.json'),
      body: jsonEncode(
        {
          'id': people.id,
          'name': people.name,
          'date': people.date.toIso8601String(),
          'isVerify': people.isVerify
        } 
      )
    );

    // Encontre o mês correspondente na lista local
    final monthIndex = _meses.indexWhere((month) => month.id == mesId);
    if (monthIndex >= 0) {
      // Adiciona a nova pessoa à lista local
      _meses[monthIndex].peoples.add(people);
      notifyListeners(); // Notifica os ouvintes sobre a mudança
    }
    scheduleBirthdayNotification(people.date, people.name);
    //notifyListeners();
  }

  Future<void> updatePeople(People people, String mesId) async {
    
    //selecina o index de um mes dentro da lista local
    int index = _meses.indexWhere((p) => p.id == mesId);
    
    await http.patch(Uri.parse('${DbRoutes.MESES_BASE_URL}/$mesId/peoples/${people.id}.json'),
    body: jsonEncode(
      {
        'name': people.name,
        'date':people.date.toIso8601String(),
      }
    )
    );
    //seleciona o index de uma pessoa dentro de um mes 
    int pessoa = _meses[index].peoples.indexWhere((p) => p.id == people.id);
    
    _meses[index].peoples[pessoa] = people;
    notifyListeners();
  }

  Future<void> removePeople( String peopleId, String mesId) async {
    try {
      
      final monthIndex = _meses.indexWhere((month) => month.id == mesId);

      if (monthIndex >= 0) {
        final peopleList = _meses[monthIndex].peoples;

        // Encontra o índice da pessoa na lista
        final peopleIndex = peopleList.indexWhere((person) => person.id == peopleId);
            
          if (peopleIndex >= 0) {
            // Realiza a requisição DELETE para remover a pessoa do banco de dados
            final response = await http.delete(Uri.parse('${DbRoutes.MESES_BASE_URL}/$mesId/peoples/$peopleId.json'));

            if (response.statusCode >= 200 && response.statusCode < 300) {
              
              peopleList.removeAt(peopleIndex);
              notifyListeners(); // Notifica os ouvintes sobre a mudança
              print('Pessoa deletada com sucesso! = ${response.statusCode.toString()}');
            
            } else {
              
              print('Erro: ${response.body}');
              throw HttpExceptions(
                msg: 'Não foi possível excluir a pessoa!',
                statusCode: response.statusCode,
              );

            }
          } else {
            throw Exception('Pessoa não encontrada.');
          }
          
        } else {
          throw Exception('Mes não encontrado.');
        }
    } catch (error) {
      print('Erro ao deletar a pessoa: ${error.toString()}');
      throw error;
    }
  }
  //flutter local notifications
  Future<void> scheduleBirthdayNotification(DateTime birthday, String name) async {
    final now = DateTime.now();
    final notificationDate = DateTime(birthday.year, birthday.month, birthday.day - 1);

    if (notificationDate.isAfter(now)) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0, // ID da notificação
        'Aniversário chegando!',
        'Amanhã é o aniversário de $name!',
        tz.TZDateTime.from(notificationDate, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'birthday_channel', // ID do canal
            'Notificações de Aniversário', // Nome do canal
            channelDescription:'Este canal é usado para lembretes de aniversários.', // Descrição do canal
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    }
  }


}