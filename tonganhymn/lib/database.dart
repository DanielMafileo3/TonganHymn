import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = "todom";
final String Column_id = "id";
final String Column_number = "number";
final String Column_mita = "mita";
final String Column_title = "title";

class TaskModel {
  final String number;
  final String title;
  final String mita;
  int id;

  TaskModel(
      {required this.number,
      required this.id,
      required this.mita,
      required this.title});

  Map<String, dynamic> toMap() {
    return {Column_number: number, Column_mita: mita, Column_title: title};
  }
}

class TodoHelper {
  Database? db;

  TodoHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "databse.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName($Column_id INTEGER PRIMARY KEY AUTOINCREMENT, $Column_number TEXT, $Column_mita TEXT, $Column_title TEXT)");
    }, version: 1);
  }

  Future<int> delete(int id) async {
    return await db!
        .delete(tableName, where: '$Column_id = ?', whereArgs: [id]);
  }

  Future<void> insertTask(TaskModel task) async {
    try {
      db!.insert(tableName, task.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (_) {
      print(_);
    }
  }

  Future<List<TaskModel>> getAllTask() async {
    final List<Map<String, dynamic>> tasks = await db!.query(tableName);

    return List.generate(tasks.length, (i) {
      return TaskModel(
          number: tasks[i][Column_number],
          id: tasks[i][Column_id],
          mita: tasks[i][Column_mita],
          title: tasks[i][Column_title]);
    });
  }
}
