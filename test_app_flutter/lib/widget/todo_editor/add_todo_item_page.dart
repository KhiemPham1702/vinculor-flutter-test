import 'package:flutter/material.dart';
import 'package:test_app_flutter/widget/controller/app_controller.dart';

class AddTodoItemPage extends StatefulWidget {
  const AddTodoItemPage({super.key});

  @override
  State<AddTodoItemPage> createState() => _AddTodoItemPageState();
}

class _AddTodoItemPageState extends State<AddTodoItemPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String? _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty ? 'Title is required' : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context, TodoItem(title: _title, description: _description));
    }
  }
}
