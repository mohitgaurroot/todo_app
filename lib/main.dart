import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/screens/todo_screen.dart';
import 'package:todo_app/services/repository.dart';
import 'bloc/todo_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (context) => TodoRepository(),
        child: BlocProvider(
          create: (context) =>
          TodoBloc(todoRepository: context.read<TodoRepository>())
            ..add(LoadTodos()),
          child: TodoScreen(),
        ),
      ),
    );
  }
}
