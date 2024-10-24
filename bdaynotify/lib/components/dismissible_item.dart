import 'package:bdaynotify/components/formPeopleUpdate.dart';
import 'package:bdaynotify/models/month_item.dart';
import 'package:bdaynotify/models/peoples.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DismissibleItem extends StatelessWidget {
  
  People people;
  String mesId;
 
  
  DismissibleItem({  required this.mesId, required this.people, super.key});

  @override
  Widget build(BuildContext context) {
    

    _showPeopleUpdateModal(BuildContext context){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Bordas arredondadas
            ),
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FormPeopleUpdate(mesId: mesId, people: people,),
            ),
          );
        },
      );
    }

    return Dismissible(
      key: ValueKey(people.id),
      direction: DismissDirection.endToStart,
      background: Container(
        height: 70,
        color: Theme.of(context).colorScheme.error,
        child:  const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20,),
        
      ),
      confirmDismiss: (_){
        return showDialog(
          context: context, 
          builder: (ctx) => AlertDialog(
            title: Text('Tem Certeza?'),
            content: Text('Quer remover essa pessoa?'),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                }, 
                child: Text('Não')
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
                }, 
                child: Text('Sim')
              )
            ],
          )
        );
      },
      onDismissed: (_)async{
        try {
          await Provider.of<MonthItem>(context, listen: false).removePeople( people.id, mesId);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pessoa removida com sucesso')));
        } catch (error) {
          // Reverter o estado se falhar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao remover ${people.name}. Tente novamente. Error: $error'),
            ),
          );
        }
        
      },
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
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
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
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                Text(DateFormat('dd/MM/y').format(people.date), 
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              padding: const EdgeInsets.only(right: 5),
              onPressed: () async{
                _showPeopleUpdateModal(context); 
              }, 
              icon: Icon(Icons.edit, color: Colors.white)
            )
          ],
        ),
      )
    );
  }
}