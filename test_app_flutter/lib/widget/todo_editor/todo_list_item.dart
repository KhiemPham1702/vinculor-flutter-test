import 'package:flutter/material.dart';
import 'package:test_app_flutter/widget/controller/app_controller.dart';

class TodoListItem extends StatefulWidget {
  final TodoItem item;
  final AppController appController;

  const TodoListItem({
    Key? key,
    required this.item,
    required this.appController,
  }) : super(key: key);

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  bool isLoading = false;

  Future<void> _toggleCheckbox(bool? newValue) async {
    if (newValue == null) return;
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    final updatedItem = TodoItem(
      title: widget.item.title,
      description: widget.item.description,
      isDone: newValue,
    );

    widget.appController.todoItemsEmitter.value = widget.appController.todoItemsEmitter.value
        .map((i) => i == widget.item ? updatedItem : i)
        .toList();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.item.isDone,
        onChanged: isLoading ? null : _toggleCheckbox,
      ),
      title: Text(
        widget.item.title,
        style: TextStyle(
          decoration: widget.item.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text(widget.item.description ?? ''),
    );
  }
}