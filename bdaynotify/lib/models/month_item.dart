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
      itens.add(
        Months(
          id: monthId, 
          name: monthData['name'], 
          peoples: (monthData['peoples'] != null && monthData['peoples'] is List<dynamic>)
          ? (monthData['peoples'] as List<dynamic>).map((item){
            return People(
              id: item['id'], 
              name: item['name'], 
              date: DateTime.parse(item['date']),
              isVerify: item['isVerify'],
            );
          }).toList()
          : [],
        ));
    });
    print('Loaded months: ${itens.map((m) => m.name).toList()}');
    _meses = itens.toList();
    notifyListeners();
  }

  Future<void> saveMonth(Map<String, Object> data){

    final product = Months(
      id: Random().nextDouble().toString(), 
      name: data['name'] as String, 
      peoples: [
        People(
        id: Random().nextDouble().toString(),
        name: 'Teste Pessoa',
        date: DateTime.now(),  // Data de exemplo
                // Verificado
      ),
      ],
    ); 
    
    return addMonth(product);
    
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
}