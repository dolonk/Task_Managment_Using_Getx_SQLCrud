import 'package:sqflite/sqflite.dart';
import 'package:task_mnagment/models/task_model.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'tasks';

  static Future<void> intDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = await getDatabasesPath() + 'tasks_db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        print("Created a new one");
        return db.execute(
          "CREATE TABLE  $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title STRING, note TEXT, date STRING, "
          "startTime STRING, endTime STRING, "
          "remind INTEGER, repeat INTEGER, "
          "color INTEGER, "
          "isCompleted INTEGER)",
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print("insert function called");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("Query function called");
    return await _db!.query(_tableName);
  }

  static delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    print('Update function called');
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id =?
    ''', [1, id]);
  }
}
