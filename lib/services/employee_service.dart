import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:pis/models/employee.dart';

class EmployeeUtil {
  DatabaseReference _counterRef;
  DatabaseReference _employeeRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = FirebaseDatabase();
  int _counter;
  DatabaseError error;

  static final EmployeeUtil _instance =
     EmployeeUtil.internal();

  EmployeeUtil.internal();

  factory EmployeeUtil() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counterEmployee');
    // Demonstrates configuring the database directly

    _employeeRef = database.reference().child('employee');
    database.reference().child('counterEmployee').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);

    _counterSubscription = _counterRef.onValue.listen((Event event) {
      error = null;
      _counter = event.snapshot.value ?? 0;
    }, onError: (Object o) {
      error = o;
    });
  }

  DatabaseError getError() {
    return error;
  }

  int getCounter() {
    return _counter;
  }

  DatabaseReference getEmployee() {
    return _employeeRef;
  }

  addEmployee(Employee employee) async {
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _employeeRef.push().set(<String, String>{
        "firstname": "" + employee.firstname,
        "lastname": "" + employee.lastname,
        "gender": "" + employee.gender,
        "phone": "" + employee.phone,
      }).then((_) {
        print('Transaction  committed.');
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  void deleteEmployee(Employee employee) async {
    await _employeeRef.child(employee.id.toString()).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateEmployee(Employee employee) async {
    await _employeeRef.child(employee.id.toString()).update({
      "firstname": "" + employee.firstname,
      "lastname": "" + employee.lastname,
      "gender": "" + employee.gender,
      "phone": "" + employee.phone,
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void dispose() {
    // _messagesSubscription.cancel();
    // _counterSubscription.cancel();
  }
}