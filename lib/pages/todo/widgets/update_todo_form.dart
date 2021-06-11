import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_sqlite/model/todo.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_bloc.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_event.dart';

class UpdateToDoForm extends StatelessWidget {
  final ToDo toDo;
  final TextEditingController title;
  final TextEditingController description;
  const UpdateToDoForm(
      {Key? key,
      required this.toDo,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Switch(
                  value: toDo.isDone,
                  onChanged: (value) => BlocProvider.of<ToDoBloc>(context)
                      .add(ToDoChangeIsDone(toDo))),
              toDo.isDone
                  ? Text(
                      'Concluído',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  : Text(
                      'Pendente',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
            ],
          ),
          TextFormField(
            controller: title,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
          TextFormField(
            controller: description,
            maxLines: 18,
            style: TextStyle(color: Colors.white60, fontSize: 18),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
