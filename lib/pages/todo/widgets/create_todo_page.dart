import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_bloc.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_event.dart';

class CreateToDoPage extends StatelessWidget {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Anotação'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.88,
              child: Column(
                children: [
                  TextFormField(
                    controller: _title,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Titulo',
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                  ),
                  TextFormField(
                    controller: _description,
                    maxLines: 5,
                    style: TextStyle(color: Colors.white60, fontSize: 18),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Descreva sua anotação aqui...',
                      hintStyle: TextStyle(color: Colors.white60),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).accentColor)),
                      child: Container(
                          height: MediaQuery.of(context).size.height * .05,
                          alignment: Alignment.center,
                          child: Text(
                            'Criar Anotação',
                            style: TextStyle(color: Colors.black),
                          )),
                      onPressed: () {
                        BlocProvider.of<ToDoBloc>(context)
                            .add(ToDoCreate(_title.text, _description.text));

                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
