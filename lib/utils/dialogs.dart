import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../model/todo_model.dart';

Future<void> displayAddDialog(BuildContext context, TextEditingController controller) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext builder) {
      return AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter todo title'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              controller.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              final todo = Todo(
                title: controller.text,
              );
              context.read<TodoBloc>().add(AddTodo(todo: todo));
              controller.clear();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> displayEditDialog(BuildContext context, Todo todo, TextEditingController controller) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext builder) {
      return AlertDialog(
        title: const Text('Edit Todo'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Edit todo title'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              controller.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              final updatedTodo = todo.copyWith(
                title: controller.text,
              );
              context.read<TodoBloc>().add(UpdateTodo(todo: updatedTodo));
              controller.clear();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}