import 'dart:convert';
import 'dart:math';

import 'package:bdaynotify/models/months.dart';
import 'package:bdaynotify/models/peoples.dart';
import 'package:bdaynotify/utils/db_routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
              id: value['id'], 
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
    
    //notifyListeners();
  }
}