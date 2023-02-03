// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

class Describtion {
  int description_id;
  String description;
  int taskId;
  bool checked = false;
  int isDone;
  Describtion(
      {required this.description_id,
      required this.taskId,
      required this.description,
      this.isDone = 0});

  Map<String, dynamic> toMap() {
    return {
      'description_id': description_id,
      'taskId': taskId,
      'description': description,
      'isDone': isDone
    };
  }

  factory Describtion.fromMap(Map<dynamic, dynamic> data) {
    return Describtion(
      description_id: data["description_id"],
      taskId: data["taskId"],
      description: data["description"],
      isDone: data['isDone'] ?? 0,
    );
  }
}
