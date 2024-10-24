import 'package:bdaynotify/components/datePicker.dart';
import 'package:bdaynotify/models/month_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthForm extends StatefulWidget {
  const MonthForm({required this.mesId, super.key});

  final String mesId;

  @override
  State<MonthForm> createState() => _MonthFormState();
}

class _MonthFormState extends State<MonthForm> {

  final _nomeControler = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _submitForm() async{

    if (_nomeControler.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Nome vazio!'),
          content: Text('Por favor, insira o nome da pessoa antes de adicionar.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(), 
              child: Text('OK')
            )
          ],
        ),
      );
      return;
    }

    final _formData = {
      'name': _nomeControler.text,
      'date': _selectedDate,
    };

    try {
      await Provider.of<MonthItem>(context, listen: false).savePeople(_formData, widget.mesId);
      Provider.of<MonthItem>(context, listen: false).loadMonths();
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog(
          context: context, 
          builder: (ctx) => AlertDialog(
            title: Text('Ocorreu um erro!'),
            content: Text('Ocorreu um erro ao adicionar uma nova pessoa! Error: $error'),
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
                child: Text('Adicionar Pessoa')
              ),
            ],
          ),
        ),
      ),
    );
  }
}