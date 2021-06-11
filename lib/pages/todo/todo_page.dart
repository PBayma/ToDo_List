import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:teste_sqlite/model/todo.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_event.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_state.dart';
import 'package:teste_sqlite/pages/todo/widgets/create_todo_page.dart';
import 'package:teste_sqlite/pages/todo/widgets/todo_card_widget.dart';
import 'package:teste_sqlite/pages/todo/widgets/update_todo_page.dart';

import 'bloc/todo_bloc.dart';

class ToDoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Anotações',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: BlocBuilder(
        bloc: BlocProvider.of<ToDoBloc>(context),
        builder: (BuildContext context, state) {
          if (state is ToDosLoadedState)
            return SingleChildScrollView(
              child: state.toDoList.isEmpty
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      alignment: Alignment.center,
                      child: Text(
                        'Nenhuma Anotação',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: StaggeredGridView.countBuilder(
                          crossAxisCount: 4,
                          staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                          itemCount: state.toDoList.length,
                          itemBuilder: (context, index) {
                            ToDo toDo = state.toDoList[index];

                            return GestureDetector(
                              child: ToDoCardWidget(toDo: toDo, index: index),
                              onTap: () => _updateToDo(context, toDo),
                            );
                          },
                        ),
                      ),
                    ),
            );
          if (state is ToDoLoadingtate)
            return Center(child: CircularProgressIndicator());
          if (state is ToDoErrorState) return Text(state.message);
          return Center(
            child: Text('estado inicial'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await _createToDo(context);
        },
      ),
    );
  }
}

_updateToDo(BuildContext blocContext, ToDo toDo) {
  Navigator.of(blocContext)
      .push(MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (BuildContext context) =>
                    ToDoBloc(ToDoLoadedState(toDo)),
                child: UpdateToDoPage(
                  toDo: toDo,
                ),
              )))
      .then(
        (value) => BlocProvider.of<ToDoBloc>(blocContext).add(
          ToDoPageStarted(),
        ),
      );
}

_createToDo(BuildContext blocContext) {
  Navigator.of(blocContext)
      .push(MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (BuildContext context) => ToDoBloc(ToDoInitialState()),
                child: CreateToDoPage(),
              )))
      .then(
        (value) => BlocProvider.of<ToDoBloc>(blocContext).add(
          ToDoPageStarted(),
        ),
      );
}
