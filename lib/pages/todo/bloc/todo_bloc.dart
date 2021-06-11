import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_sqlite/db/todo_database.dart';
import 'package:teste_sqlite/model/todo.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_event.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_state.dart';
import 'package:uuid/uuid.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc(ToDoState initialState) : super(ToDoInitialState());

  Stream<ToDoState> mapEventToState(event) async* {
    if (event is ToDoPageStarted) {
      yield ToDoLoadingtate();
      try {
        yield* _fetchToDos();
      } catch (e) {
        yield ToDoErrorState('Não foi possível carregar os dados');
      }
    }
    if (event is ToDoCreate) {
      yield ToDoLoadingtate();
      try {
        var uuid = Uuid();
        String id = uuid.v4();
        final ToDo toDo = ToDo(id, event.title, event.description, false);
        await ToDoDatabase.create(toDo);
      } catch (e) {}
    }
    if (event is ToDoUpdate) {
      yield ToDoLoadingtate();
      try {
        ToDo toDo = event.toDo;
        await ToDoDatabase.update(toDo);
        yield ToDoLoadedState(toDo);
      } catch (e) {}
    }
    if (event is ToDoChangeIsDone) {
      yield ToDoLoadingtate();
      try {
        ToDo toDo = event.toDo;
        toDo.isDone = !toDo.isDone;
        yield ToDoLoadedState(toDo);
      } catch (e) {}
    }
    if (event is ToDoDelete) {
      yield ToDoLoadingtate();
      try {
        await ToDoDatabase.delete(event.id);
        yield* _fetchToDos();
      } catch (e) {}
    }
  }

  Stream<ToDoState> _fetchToDos() async* {
    try {
      final List<ToDo> toDoList = await ToDoDatabase.getAll();
      yield ToDosLoadedState(toDoList);
    } catch (e) {}
  }
}
