import 'package:bdaynotify/components/card_people.dart';
import 'package:bdaynotify/components/form_people_config_modal.dart';
import 'package:bdaynotify/models/month_item.dart';
import 'package:bdaynotify/models/months.dart';
import 'package:bdaynotify/screens/month_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthDetailScreem extends StatelessWidget {
  const MonthDetailScreem({super.key});

  @override
  Widget build(BuildContext context) {

    _openPeopleFormModal(BuildContext context, Months mes){
      showModalBottomSheet(
        context: context, 
        builder: (_) => MonthForm(mesId: mes.id,)
      );
       
    }

    _showPeopleConfigModal(BuildContext context, Months mes){
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
              child: FormPeopleConfigModal(mes: mes,),
            ),
          );
        } 
      );
    }

    Months mes = ModalRoute.of(context)!.settings.arguments as Months;
      // Inspecionar o conteúdo da lista de peoples
     print('Lista de peoples: ${mes.peoples}');
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          mes.name, 
          style: TextStyle(
            color:  Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF2D378D),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => _showPeopleConfigModal(context, mes), 
            icon: const Icon(
              Icons.more_vert, 
              color: Colors.white,
            )
          )
        ],
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.only(
            left: 40,
            right: 40,
            top: 40
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2D378D),
                Color(0xFF5A6AF1)
              ],
              begin: Alignment.topCenter,
              end: Alignment.center
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 600,
                child:  ListView.builder(
                  itemCount: mes.peoples.length,
                  itemBuilder: (ctx, i) => CardPeople(mesId: mes.id ,people: mes.peoples[i])
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2D378D),
        onPressed: () => _openPeopleFormModal(context, mes),
        child: const Icon(Icons.person_add_alt_1, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}