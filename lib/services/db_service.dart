import 'package:sqflite/sqflite.dart';

class DbHelper {
  String dbPath;
  Database db;

//  Future<Database> dbOpen(String dbName) async {
//    String databasesPath = await getDatabasesPath();
//    dbPath = join(databasesPath, dbName);
//
//    db = await openDatabase(
//      dbPath,
//      version: 1,
//      onCreate: (Database db, int version) async {
//        await db.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, task TEXT, isDone INTEGER)');
//      },
//    );
//
//    return db;
//  }
//
//  Future<void> insertTask(Task task) async {
//    // Insert the Dog into the correct table. Also specify the
//    // `conflictAlgorithm`. In this case, if the same dog is inserted
//    // multiple times, it replaces the previous data.
//    await db.insert(
//      'tasks',
//      task.toMap(),
//      conflictAlgorithm: ConflictAlgorithm.ignore,
//    );
//  }
//
//  Future<List<Task>> tasks() async {
//    // Query the table for all The Dogs.
//    final List<Map<String, dynamic>> maps = await db.query('tasks');
//
//    // Convert the List<Map<String, dynamic> into a List<Dog>.
//    return List.generate(maps.length, (i) {
//      return Task(
//        id: maps[i]['id'],
//        taskText: maps[i]['name'],
//        isDone: maps[i]['age'],
//      );
//    });
//  }
//
//  Future<void> updateDog(Task task) async {
//    // Update the given Dog.
//    await db.update(
//      'tasks',
//      task.toMap(),
//      // Ensure that the Dog has a matching id.
//      where: "id = ?",
//      // Pass the Dog's id as a whereArg to prevent SQL injection.
//      whereArgs: [task.id],
//    );
//  }
//
//  Future<void> deleteTask(int id) async {
//    // Remove the Dog from the database.
//    await db.delete(
//      'tasks',
//      // Use a `where` clause to delete a specific dog.
//      where: "id = ?",
//      // Pass the Dog's id as a whereArg to prevent SQL injection.
//      whereArgs: [id],
//    );
//  }
}
