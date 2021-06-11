import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_bloc.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_event.dart';
import 'package:teste_sqlite/pages/todo/bloc/todo_state.dart';
import 'package:teste_sqlite/pages/todo/todo_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.orange[500],
        scaffoldBackgroundColor: Colors.blueGrey.shade900,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: BlocProvider(
          create: (BuildContext context) =>
              ToDoBloc(ToDoInitialState())..add(ToDoPageStarted()),
          child: ToDoPage()),
      debugShowCheckedModeBanner: false,
    );
  }
}
