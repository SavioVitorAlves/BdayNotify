import 'package:bdaynotify/components/dismissible_item.dart';
import 'package:bdaynotify/models/months.dart';
import 'package:flutter/material.dart';

class FormPeopleConfigModal extends StatelessWidget {
  Months mes;
  
  FormPeopleConfigModal({required this.mes, super.key});

  @override
  Widget build(BuildContext context) {
    
    return Column(
      mainAxisSize: MainAxisSize.min, // O conteúdo não ocupa mais espaço do que o necessário
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Edição',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        Container(
          height: 500,
          child: ListView.builder(
            itemCount: mes.peoples.length,
            itemBuilder: (ctx, i) => DismissibleItem(people: mes.peoples[i], mesId: mes.id,)
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: Text('Sair')
        )
      ],
    );
  }
}