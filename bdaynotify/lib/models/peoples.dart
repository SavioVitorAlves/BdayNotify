import 'dart:convert';

import 'package:bdaynotify/utils/db_routes.dart';

import 'package:http/http.dart' as http;

class People{
  final String id;
  final String name;
  final DateTime date;
  bool isVerify;
  People({
    required this.id,
    required this.name,
    required this.date,
    this.isVerify = false
  });

  // Método para converter People para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),  // Converte DateTime para String
      'isVerify': isVerify,
    };
  }

  void _toggleVerify(){
    isVerify = !isVerify;
   
  }

  Future<void> toggleVerify(String mesId, String peopleId)async{
    _toggleVerify();
    
    try{
      print(mesId);
      print(id);
      print(peopleId);
      final response = await http.patch(
        Uri.parse('${DbRoutes.MESES_BASE_URL}/$mesId/peoples/$peopleId.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'isVerify': isVerify}),
      );
      if (response.statusCode == 200) {
          print('Verificação atualizada com sucesso no banco de dados.');
        } else {
          print('Erro ao atualizar no banco de dados. Status code: ${response.statusCode}');
        }
    } catch (error) {
      print('Erro durante a requisição PUT: $error');
    }
  }

  

  


}
