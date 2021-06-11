import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:teste_sqlite/model/todo.dart';

@immutable
abstract class ToDoState extends Equatable {
  List<Object> get props => [];
}

class ToDoInitialState extends ToDoState {}

class ToDoLoadingtate extends ToDoState {}

class ToDoErrorState extends ToDoState {
  final String message;

  ToDoErrorState(this.message);
}

class ToDoLoadedState extends ToDoState {
  final ToDo toDo;

  ToDoLoadedState(this.toDo);
}

class ToDosLoadedState extends ToDoState {
  final List<ToDo> toDoList;

  ToDosLoadedState(this.toDoList);
}
