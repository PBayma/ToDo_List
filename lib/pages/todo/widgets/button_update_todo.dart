import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_sqlite/model/todo.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_bloc.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_event.dart';

class ButtonUpdateToDo extends StatelessWidget {
  final ToDo toDo;
  final String title;
  final String description;
  const ButtonUpdateToDo({
    Key? key,
    required this.toDo,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).accentColor)),
        child: Container(
            height: MediaQuery.of(context).size.height * .05,
            alignment: Alignment.center,
            child: Text(
              'Atualizar Anotação',
              style: TextStyle(color: Colors.black),
            )),
        onPressed: () {
          ToDo updatedToDo = ToDo(toDo.id, title, description, toDo.isDone);

          BlocProvider.of<ToDoBloc>(context).add(ToDoUpdate(updatedToDo));

          Navigator.pop(context);
        });
  }
}
