import 'package:bdaynotify/models/month_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthForm extends StatefulWidget {
  const MonthForm({super.key});

  @override
  State<MonthForm> createState() => _MonthFormState();
}

class _MonthFormState extends State<MonthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
   bool _isLoading = false;

  Future<void> _submitForm() async{
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<MonthItem>(context, listen: false).saveMonth(_formData);
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog(
          context: context, 
          builder: (ctx) => AlertDialog(
            title: Text('Ocorreu um erro!'),
            content: Text('Ocorreu um erro para salvar o produto!$error'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(), 
                child: Text('OK')
              )
            ],
          )

        );
    }finally{
       setState(() {
        _isLoading = false;
      });
    }
    
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm, 
            icon: Icon(Icons.save, color: Colors.white,)
          )
        ],
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                onSaved: (name) => _formData['name'] = name ?? '',
              ),
            ],
          ),
        )
      ),
    );
  }
}