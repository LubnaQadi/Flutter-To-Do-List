// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import '/database/task_provider.dart';

import '../../model/description/describtion.dart';

class DescritionTask extends StatefulWidget {
  final Describtion describtion;
  const DescritionTask(this.describtion, {Key? key}) : super(key: key);

  @override
  State<DescritionTask> createState() => _DescritionTaskState();
}

class _DescritionTaskState extends State<DescritionTask> {
  @override
  Widget build(BuildContext context) {
    print(widget.describtion.isDone);
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Checkbox(
            value: (widget.describtion.isDone == 1),
            onChanged: (value) {
              setState(() {
                // widget.onCheck(widget.describtion);
                if (value == true) {
                  widget.describtion.isDone = 1;
                } else {
                  widget.describtion.isDone = 0;
                }
              });
            },
          ),
          title: Text(
            widget.describtion.description,
            style: const TextStyle(fontSize: 15, color: Colors.black),
          ),
          trailing: IconButton(
              onPressed: () {
                TaskProvider.db
                    .removeSubtask(widget.describtion.description_id);
                setState(() {});
              },
              icon: Icon(
                Icons.close_sharp,
                color: Colors.redAccent,
              )),
        ),
      ),
    );
  }
}
