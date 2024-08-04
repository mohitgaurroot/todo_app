import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../model/todo_model.dart';
import '../services/repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc({required this.todoRepository}) : super(TodoLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final todos = await todoRepository.getTodos();
      emit(TodoLoaded(todos: todos));
    } catch (_) {
      emit(TodoError());
    }
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      await todoRepository.addTodo(event.todo);
      final updatedTodos = await todoRepository.getTodos();
      emit(TodoLoaded(todos: updatedTodos));
    }
  }

  Future<void> _onUpdateTodo(
      UpdateTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      await todoRepository.updateTodo(event.todo);
      final updatedTodos = await todoRepository.getTodos();
      emit(TodoLoaded(todos: updatedTodos));
    }
  }

  Future<void> _onDeleteTodo(
      DeleteTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      await todoRepository.deleteTodo(event.id);
      final updatedTodos = await todoRepository.getTodos();
      emit(TodoLoaded(todos: updatedTodos));
    }
  }
}
