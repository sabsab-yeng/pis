import 'dart:async';
import 'package:path/path.dart';
import 'package:pis/ui/screens/customer/customer_model.dart';
import 'package:sqflite/sqflite.dart';
 
class CustomerDatabaseHelper {
  static final CustomerDatabaseHelper _instance = new CustomerDatabaseHelper.internal();
 
  factory CustomerDatabaseHelper() => _instance;
 
  final String tableCustomer = 'customerTable';
  final String columnId = 'id';
  final String columnFirstName = 'firstname';
  final String columnGender = 'gender';
  final String columnPhone = 'phone';
 
  static Database _db;
 
  CustomerDatabaseHelper.internal();
 
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
 
    return _db;
  }
 
  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'pis.db');
 
//    await deleteDatabase(path); // just for testing
 
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
 
  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableCustomer($columnId INTEGER PRIMARY KEY, $columnFirstName TEXT, $columnGender TEXT, $columnPhone TEXT)');
  }
 
  Future<int> saveNote(Customer customer) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableCustomer, customer.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');
 
    return result;
  }
 
  Future<List> getAllNotes() async {
    var dbClient = await db;
    var result = await dbClient.query(tableCustomer, columns: [columnId, columnFirstName, columnGender, columnPhone]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');
 
    return result.toList();
  }
 
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableCustomer'));
  }
 
  Future<Customer> getNote(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableCustomer,
        columns: [columnId, columnFirstName, columnGender, columnPhone],
        where: '$columnId = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
 
    if (result.length > 0) {
      return new Customer.fromMap(result.first);
    }
 
    return null;
  }
 
  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableCustomer, where: '$columnId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }
 
  Future<int> updateNote(Customer customer) async {
    var dbClient = await db;
    return await dbClient.update(tableCustomer, customer.toMap(), where: "$columnId = ?", whereArgs: [customer.id]);
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $columnTitle = \'${note.title}\', $columnDescription = \'${note.description}\' WHERE $columnId = ${note.id}');
  }
 
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}