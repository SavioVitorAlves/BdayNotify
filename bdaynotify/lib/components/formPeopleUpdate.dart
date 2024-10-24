import 'package:bdaynotify/components/datePicker.dart';
import 'package:bdaynotify/models/month_item.dart';
import 'package:bdaynotify/models/peoples.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormPeopleUpdate extends StatefulWidget {
  
   final String mesId;
   People people;
  
  FormPeopleUpdate({required this.mesId, required this.people, super.key});

  @override
  State<FormPeopleUpdate> createState() => _FormPeopleUpdateState();
}

class _FormPeopleUpdateState extends State<FormPeopleUpdate> {
  
  final _nomeControler = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  
  Future<void> _submitForm() async{

    final _formData = {
      'name': _nomeControler.text.isEmpty ? widget.people.name : _nomeControler.text,
      'date': _selectedDate == DateTime.now() ? widget.people.date : _selectedDate,
    };

    try {
      await Provider.of<MonthItem>(context, listen: false).save(_formData, widget.mesId, widget.people.id);
      Provider.of<MonthItem>(context, listen: false).loadMonths();
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog(
          context: context, 
          builder: (ctx) => AlertDialog(
            title: Text('Ocorreu um erro!'),
            content: Text('Ocorreu um erro ao atualizar a pessoa! Error: $error'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(), 
                child: Text('OK')
              )
            ],
          )

        );
    }
    
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom
          ),
          child: Column(
            children: [
              TextField(
                controller: _nomeControler,
                decoration: InputDecoration(
                  label: Text('Nome')
                ),
              ),
              Datepicker(
                onDateChanged: (newDate){
                  setState(() {
                    _selectedDate = newDate;
                  });
                }, 
                selectedDate: _selectedDate
              ),
              FilledButton(
                onPressed: _submitForm, 
                child: Text('Atualizar Pessoa')
              ),
            ],
          ),
        ),
      ),
    );
  }
}