class Task {
  int? id;
  String? task;
  String? endDate;
  String? date;
  int isDone;
  String type;

  Task(
      {this.id,
      required this.task,
      required this.date,
      required this.endDate,
      this.isDone = 0,
      required this.type});
  set taskDate(String value) {
    date = value;
  }

  String get taskDate => date!;
  bool value = false;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'date': date,
      'endDate': endDate,
      'isDone': isDone,
      'type': type
    };
  }

  factory Task.fromMap(Map<dynamic, dynamic> data) {
    return Task(
        id: data["id"],
        task: data["task"],
        date: data["date"],
        endDate: data["endDate"],
        isDone: data["isDone"],
        type: data["type"] ?? '');
  }
}
