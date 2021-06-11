import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:teste_sqlite/model/todo.dart';

class ToDoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

@immutable
class ToDoPageStarted extends ToDoEvent {}

@immutable
class ToDoCreate extends ToDoEvent {
  final String title;
  final String description;

  ToDoCreate(this.title, this.description);
}

@immutable
class ToDoUpdate extends ToDoEvent {
  final ToDo toDo;

  ToDoUpdate(this.toDo);
}

class ToDoChangeIsDone extends ToDoEvent {
  final ToDo toDo;

  ToDoChangeIsDone(this.toDo);
}

@immutable
class ToDoDelete extends ToDoEvent {
  final String id;

  ToDoDelete(this.id);
}

@immutable
class ToDoPageError extends ToDoEvent {}
