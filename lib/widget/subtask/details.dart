import 'package:flutter/material.dart';
import '/database/task_provider.dart';
import '/model/description/describtion.dart';
import '/model/description/create-describtion-dto.dart';
import '/widget/subtask/describtion-list.dart';

import '/model/tasks.dart';

TextEditingController subtaskController = TextEditingController();

class TaskDetails extends StatefulWidget {
  final Task task;
  const TaskDetails(this.task, {Key? key}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  List<Describtion>? description;

  @override
  Widget build(BuildContext context) {
    subtaskController.clear();
    return Scaffold(
        drawerScrimColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            "Inbox",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
            size: 25,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.list_alt),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              '${widget.task.date}   ',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.blueAccent),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.flag_sharp,
                          size: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.task.task!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                      ],
                    )
                  ],
                )),
            TextField(
              onEditingComplete: () {
                TaskProvider.db.SubTaskinsert(CreateDescribtionDto(
                    taskId: widget.task.id!,
                    description: subtaskController.text));

                setState(() {
                  subtaskController.clear();
                });
              },
              autofocus: false,
              controller: subtaskController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0, color: Color.fromARGB(255, 254, 255, 255))),
                labelText: 'Description',
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: TaskProvider.db.getSubTasks(widget.task.id!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Describtion>? description =
                        snapshot.data as List<Describtion>?;
                    return ListView.builder(
                      itemCount: description!.length,
                      itemBuilder: (context, index) {
                        return DescritionTask(description[index]);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Center(
                      child: Text("NO subtask"),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
