// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '/model/tasks.dart';

class TaskCompleted extends StatefulWidget {
  final Task tasks;

  const TaskCompleted(this.tasks);

  @override
  State<TaskCompleted> createState() => _TaskCompletedState();
}

class _TaskCompletedState extends State<TaskCompleted> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color.fromARGB(255, 219, 217, 217),
              width: 390,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                 /* const Checkbox(
                    value: true,
                    onChanged: null,
                  ),*/
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.tasks.task!,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 146, 145, 145),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }
}
