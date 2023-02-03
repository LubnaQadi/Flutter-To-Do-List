import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/task_provider.dart';
import '../model/tasks.dart';
import '../widget/drawer/drawer.dart';
import '../widget/subtask/details.dart';

class WishScreen extends StatefulWidget {
  const WishScreen({Key? key}) : super(key: key);

  @override
  State<WishScreen> createState() => _WishScreenState();
}

class _WishScreenState extends State<WishScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(
          child: DrawerTask(),
        ),
        appBar: AppBar(

          title: Text("Wish List", style: TextStyle(fontSize: 20),),
        ),
        body: Column(
            children: [
              FutureBuilder<List<Task>>(
                future: TaskProvider.db.getWishTasks(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Task>? taskList = snapshot.data;

                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: taskList?.length,
                        itemBuilder: (context, index) {

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
                             /* leading: Checkbox(
                                value: taskList![index].value,
                                onChanged: (value) {
                                  TaskProvider.db.updateTask(taskList[index]);
                                  setState(() {});

                                },
                              ),*/
                              title: Text(
                                taskList![index].task!,
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
                  return const Center(
                      child: CircularProgressIndicator());
                },

              ),
            ]
        )
    );
  }
}
