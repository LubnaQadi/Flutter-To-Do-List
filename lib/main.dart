import 'package:flutter/material.dart';
import '/database/task_provider.dart';
import '/widget/task/display_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<TaskProvider>(
    create: (context) => TaskProvider.db,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DisplayList(),
    );
  }
}
