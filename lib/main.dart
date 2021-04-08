import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/screens/tasks_screen.dart';
import 'package:todoey_flutter/services/hive_helper.dart';

import 'models/task.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HiveHelper(),
      child: MaterialApp(
        color: const Color(0xFFedddd4),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: Hive.openBox<Task>('tasks'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return TasksScreen();
              }
            } else {
              return Scaffold(
                backgroundColor: const Color(0xFFedddd4),
                body: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Opening ToDoey ...',
                    style: TextStyle(
                      color: Color(0xfFc44900),
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
