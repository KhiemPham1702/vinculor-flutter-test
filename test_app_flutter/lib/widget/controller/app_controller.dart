import 'package:flutter/material.dart';
import 'package:test_app_flutter/emitter/emitter.dart';
import 'package:test_app_flutter/widget/todo_editor/add_todo_item_page.dart';

class TodoItem {
  final String title;
  final String? description;
  final bool isDone;

  TodoItem({
    required this.title,
    this.description,
    this.isDone = false,
  });
}

enum AppState {
  todoEditor,
  exercise2,
  exercise3,
}

class AppController {
  final appStateEmitter = Emitter<AppState>(initialValue: AppState.todoEditor);

  final todoItemsEmitter = Emitter<List<TodoItem>>(initialValue: [
    TodoItem(title: 'First item', description: 'This is the first item', isDone: true),
    TodoItem(title: 'Second item', description: 'This is the second item'),
    TodoItem(title: 'Third item', description: 'This is the third item'),
  ]);

  void changeAppState(AppState state) {
    appStateEmitter.value = state;
  }

  Future<void> executeRpcCall() async {
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> addTodoItem(BuildContext context) async {
    final newItem = await Navigator.push<TodoItem>(
      context,
      MaterialPageRoute(builder: (context) => const AddTodoItemPage()),
    );
    if (newItem != null) {
      todoItemsEmitter.value = [...todoItemsEmitter.value, newItem];
    }
  }
}
