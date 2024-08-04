import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../utils/dialogs.dart';

class TodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      const Spacer(),
                      if (todo.isCompleted)
                        const Text(
                          'Completed',
                          style: TextStyle(color: Colors.green),
                        )
                      else
                        const Text(
                          "Pending",
                          style: TextStyle(color: Colors.blue),
                        ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!todo.isCompleted)
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _controller.text = todo.title;
                            displayEditDialog(context, todo, _controller);
                          },
                        )
                      else
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => context
                              .read<TodoBloc>()
                              .add(DeleteTodo(id: todo.id!)),
                        ),
                      Checkbox(
                        value: todo.isCompleted,
                        onChanged: (bool? value) {
                          context.read<TodoBloc>().add(UpdateTodo(
                              todo:
                                  todo.copyWith(isCompleted: value ?? false)));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Failed to load todos.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => displayAddDialog(context, _controller),
      ),
    );
  }
}
