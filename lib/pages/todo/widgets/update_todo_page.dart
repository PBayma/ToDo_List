import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_sqlite/model/todo.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_bloc.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_event.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_state.dart';
import 'package:teste_sqlite/pages/todo/widgets/button_update_todo.dart';
import 'package:teste_sqlite/pages/todo/widgets/update_todo_form.dart';

class UpdateToDoPage extends StatelessWidget {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final ToDo toDo;
  UpdateToDoPage({Key? key, required this.toDo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _title.text = toDo.title;
    _description.text = toDo.description;
    return Scaffold(
      appBar: AppBar(
        title: Text('Anotação'),
        actions: [
          TextButton(
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.orangeAccent)),
              onPressed: () {
                BlocProvider.of<ToDoBloc>(context).add(ToDoDelete(toDo.id));
                Navigator.pop(context);
              },
              child: Icon(
                Icons.delete,
                color: Theme.of(context).accentColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
          child: BlocBuilder(
        bloc: BlocProvider.of<ToDoBloc>(context),
        builder: (BuildContext context, state) {
          if (state is ToDoLoadedState) {
            return Column(
              children: [
                UpdateToDoForm(
                    toDo: state.toDo, title: _title, description: _description),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                ),
                ButtonUpdateToDo(
                  toDo: state.toDo,
                  title: _title.text,
                  description: _description.text,
                )
              ],
            );
          }
          if (state is ToDoInitialState) {
            return Column(
              children: [
                UpdateToDoForm(
                    toDo: toDo, title: _title, description: _description),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                ),
                ButtonUpdateToDo(
                  toDo: toDo,
                  title: _title.text,
                  description: _description.text,
                )
              ],
            );
          }
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).accentColor,
              )),
            ],
          );
        },
      )),
    );
  }
}

Widget _updateButton(BuildContext context, ToDo toDo) {
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
    onPressed: () => BlocProvider.of<ToDoBloc>(context).add(ToDoUpdate(toDo)),
  );
}
