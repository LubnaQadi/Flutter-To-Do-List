import 'package:flutter/cupertino.dart';
import '/model/description/create-describtion-dto.dart';
import '/model/description/describtion.dart';
import '/model/tasks.dart';
import 'package:sqflite/sqflite.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider._();
  static final TaskProvider db = TaskProvider._();
  static int version = 9;

  static Database? _database;
  static const String tableName = 'task';

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    path += 'task.db';
    return openDatabase(
      path,
      version: version,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE task (
            id INTEGER primary key AUTOINCREMENT,
            task text,
            date text,
            type text,
            endDate text,
            isDone INTEGER
            )
          
          ''');
        await db.execute('''
          CREATE TABLE taskdescription (
            description_id INTEGER primary key AUTOINCREMENT,
            taskId INTEGER,
            description text,
            isDone INTEGER
          )
          ''');
      },
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    List<Map> result = await db!.rawQuery('SELECT * FROM task WHERE isDone=0');
    List<Task> task = [];
    for (var value in result) {
      task.add(Task.fromMap(value));
    }
    return task;
  }

  Future<List<Task>> getWorkTasks() async {
    final db = await database;
    List<Map> result =
        await db!.query('task', where: "type=?", whereArgs: ["Work"]);
    List<Task> task = [];
    for (var value in result) {
      task.add(Task.fromMap(value));
    }
    return task;
  }

  updateTask(Task task) async {
    final db = await database;
    var res =
        await db!.rawUpdate('update task set isDone=1 where id=${task.id}');
    print("=============================${res}");
    return res;
  }

  Future removeTask(Task task) async {
    final db = await database;
    return await db!.delete(tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  Future<List<Describtion>> getSubTasks(int taskId) async {
    final db = await database;
    List<Map> result = await db!
        .rawQuery('SELECT * FROM taskdescription where taskId=$taskId');
    List<Describtion> desc = [];
    for (var value in result) {
      desc.add(Describtion.fromMap(value));
    }
    return desc;
  }


  Future<List<Task>> getPersonalTasks() async {
    final db = await database;
    List<Map> result =
        await db!.query('task', where: "type=?", whereArgs: ["Personal"]);
    List<Task> task = [];
    for (var value in result) {
      task.add(Task.fromMap(value));
    }
    return task;
  }

  Future<List<Task>> getBirthdayTasks() async {
    final db = await database;
    List<Map> result =
        await db!.query('task', where: "type=?", whereArgs: ["Birthday"]);
    List<Task> task = [];
    for (var value in result) {
      task.add(Task.fromMap(value));
    }
    return task;
  }

  Future<List<Task>> getShoppingTasks() async {
    final db = await database;
    List<Map> result =
        await db!.query('task', where: "type=?", whereArgs: ["Shopping"]);
    List<Task> task = [];
    for (var value in result) {
      task.add(Task.fromMap(value));
    }
    return task;
  }

  Future<List<Task>> getTodayTasks() async {
    final db = await database;
    List<Map> result =
    await db!.query('task', where: "endDate=?", whereArgs: ["Today"]);
    List<Task> task = [];
    for (var value in result) {
      task.add(Task.fromMap(value));
    }
    return task;
  }

  Future<List<Task>> getWishTasks() async {
    final db = await database;
    List<Map> result = await db!.query('task', where: "type=?", whereArgs: ["Wish List"]);
    List<Task> task = [];
    for (var value in result) {
      task.add(Task.fromMap(value));
    }
    return task;
  }

  Future<List<Task>> getDoneTasks() async {
    final db = await database;
    List<Map> result = await db!.rawQuery('SELECT * FROM task WHERE isDone=1');
    List<Task> task = [];
    for (var value in result) {
      task.add(Task.fromMap(value));
    }
    return task;
  }

  Future insert(Task task) async {
    final db = await database;
    var res = await db!.insert("task", task.toMap());
    print("=============================${res}");
    return res;
  }
/*  Future insert(text, taskDate, type, endDate) async {
    final db = await database;
    Map<String, dynamic> payload = {
      'task': text,
      'date': taskDate,
      'type': type,
      'endDate': endDate,
      'isDone': 0
    };

    var id = await db!.insert("task", payload);
    return id;
  }*/

  Future SubTaskinsert(CreateDescribtionDto desc) async {
    final db = await database;
    var res = await db!.insert("taskdescription", desc.toMap());
    return res;
  }

  Future removeSubtask(int id) async {
    final db = await database;
    return await db
        ?.rawDelete('DELETE FROM taskdescription WHERE description_id=$id');
  }
}
