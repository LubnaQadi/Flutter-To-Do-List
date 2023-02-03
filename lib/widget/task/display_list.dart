// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import '/database/task_provider.dart';
import '/model/tasks.dart';
import '../subtask/details.dart';
import 'displayCompleted_task.dart';
import '../drawer/drawer.dart';
import 'package:intl/intl.dart';
import 'dart:core';

class DisplayList extends StatefulWidget {
  const DisplayList({Key? key}) : super(key: key);

  @override
  State<DisplayList> createState() => _DisplayListState();

  void onCheck(String task) {}
}

List<Task> taskList = [];

TextEditingController taskController = TextEditingController();

class _DisplayListState extends State<DisplayList> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  DateTime date = DateTime.now();
  int noOfDays = 0;
  String endDate = "";
  int intnoDays = 0;
  String taskDate = '';
  String type = '';
  var taskType;
  List<Task> completed = [];

  int? get listLength => taskList.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: DrawerTask(),
      ),
      appBar: AppBar(
        title: const Text(
          "Inbox",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const Text(
            'To-Do Tasks',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          FutureBuilder<List<Task>>(
            future: TaskProvider.db.getTasks(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Task>? taskList = snapshot.data;

                return SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: taskList?.length,
                    itemBuilder: (context, index) {
                      //  taskType=taskList?[index].task;

                      return Container(
                        padding: const EdgeInsets.all(5),
                        margin:
                            const EdgeInsets.only(top: 5, left: 5, right: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        TaskDetails(taskList![index]))));
                          },
                          leading: Checkbox(
                            value: taskList![index].value,
                            onChanged: (value) {
                              TaskProvider.db.updateTask(taskList[index]);
                              setState(() {});
                            },
                          ),
                          title: Text(
                            taskList[index].task!,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            taskList[index].type,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black),
                          ),
                          trailing: Text(
                            taskList[index].endDate!,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.green),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Center(
                  child: Column(
                children: const [
                  Text(
                    "No tasks yet",
                    style: TextStyle(fontSize: 14),
                  ),
                  CircularProgressIndicator(),
                  Text("Add new task to appear here",
                      style: TextStyle(fontSize: 14)),
                  Text(" ")
                ],
              ));
            },
          ),
          const Text(
            'Done Tasks',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: SizedBox(
              child: FutureBuilder<List<Task>>(
                  future: TaskProvider.db.getDoneTasks(),
                  builder: (context, snapshot) {
                    List<Task>? completeList = snapshot.data;

                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: completeList!.length,
                        itemBuilder: (context, index) {
                          return TaskCompleted(
                            completeList[index],
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Center(
                        child: Text("NO Task is Complete"),
                      );
                    }
                  }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _AddTask();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_suggest_sharp), label: "")
        ],
      ),
    );
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }

  // ignore: non_constant_identifier_names
  void _AddTask() async {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        context: context,
        builder: (context) {
          return Form(
            key: _key,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: taskController,
                  decoration: const InputDecoration(
                      labelText: 'Task', border: InputBorder.none),
                  keyboardType: TextInputType.text,
                  validator: (taskController) {
                    if (taskController == null || taskController.isEmpty) {
                      return "Field is required";
                    }
                    return null;
                  },
                ),
              ),
              Stack(children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        // ignore: unused_local_variable
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: date,
                            firstDate: DateTime(1999),
                            lastDate: DateTime(2100));

                        noOfDays= calculateDifference(newDate!);

                       // noOfDays = newDate!.difference(date).inDays;
                        taskDate = DateFormat('MMM dd').format(newDate);
                        if (noOfDays == 1) {
                          endDate = 'Tomorrow';
                        } else if (noOfDays < 1 && noOfDays >= 0) {
                          endDate = 'Today';
                        } else if (noOfDays == -1) {
                          endDate = 'Yesterday';
                        } else {
                          endDate = '$noOfDays days left';
                        }
                      },
                      icon: const Icon(Icons.calendar_month_rounded),
                      color: Colors.grey,
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            context: context,
                            builder: (context) {
                              return Form(
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(
                                        Icons.work_outlined,
                                        color: Colors.brown,
                                      ),
                                      title: Text('Work'),
                                      onTap: () {
                                        type = 'Work';
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.person,
                                      ),
                                      title: Text('Personal'),
                                      onTap: () {
                                        type = 'Personal';
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.shopping_bag_outlined,
                                        color: Colors.orange,
                                      ),
                                      title: Text('Shopping'),
                                      onTap: () {
                                        type = 'Shopping';
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.cake_outlined,
                                      ),
                                      title: Text('Birthday'),
                                      onTap: () {
                                        type = 'Birthday';
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.card_giftcard_sharp,
                                        color: Colors.orange,
                                      ),
                                      title: Text('Wish List'),
                                      onTap: () {
                                        type = 'Wish List';
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: const Icon(Icons.flag_sharp),
                      color: Colors.grey,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.label),
                      color: Colors.grey,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.inbox),
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                )),
                                child: const Icon(Icons.send),
                                onPressed: () {
                                  TaskProvider.db.insert(Task(
                                    task: taskController.text,
                                    date: taskDate,
                                    type: type,
                                    endDate: endDate,
                                  ));
                                  taskController.clear();
                                  Navigator.of(context).pop();
                                  if (_key.currentState!.validate()) {
                                    _key.currentState!.setState(() {});
                                  }
                                  setState(() {});
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ]),
          );
        });
  }
}
