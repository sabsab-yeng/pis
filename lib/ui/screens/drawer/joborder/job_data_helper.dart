import 'dart:async';
import 'package:path/path.dart';
import 'package:pis/ui/screens/drawer/joborder/job_model.dart';
import 'package:sqflite/sqflite.dart';
 
class JobDatabaseHelper {
  static final JobDatabaseHelper _instance = JobDatabaseHelper.internal();
 
  factory JobDatabaseHelper() => _instance;
 
  final String tableJob = 'employeeTable';
  final String columnId = 'id';
  final String columnCustomerID = 'custid';
  final String columnEmpID = 'empid';
  final String columnDateNow = 'datenow';
  final String columnDateInstall = 'datein';
  final String columnStatus = 'status';
  // final String columnDes = 'description';
 
  static Database _db;
 
  JobDatabaseHelper.internal();
 
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
 
    return _db;
  }
 
  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'joborder.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
 
  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableJob($columnId INTEGER PRIMARY KEY, $columnCustomerID TEXT, $columnEmpID TEXT, $columnDateNow TEXT, $columnDateInstall TEXT, $columnStatus TEXT)');
  }
 
  Future<int> saveEmployee(Job employee) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableJob, employee.toMap());
    return result;
  }
 
  Future<List> getAllJobs() async {
    var dbClient = await db;
    var result = await dbClient.query(tableJob, columns: [columnId, columnCustomerID, columnEmpID, columnDateNow, columnDateInstall, columnStatus]);
    return result.toList();
  }
 
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableJob'));
  }
 
  Future<Job> getEmployee(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableJob,
        columns: [columnId, columnCustomerID, columnEmpID, columnDateNow, columnDateInstall, columnStatus],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (result.length > 0) {
      return Job.fromMap(result.first);
    }
 
    return null;
  }
 
  Future<int> deleteJob(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableJob, where: '$columnId = ?', whereArgs: [id]);
 }
 
  Future<int> updateEmployee(Job job) async {
    var dbClient = await db;
    return await dbClient.update(tableJob, job.toMap(), where: "$columnId = ?", whereArgs: [job.id]);
 }
 
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}