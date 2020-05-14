import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:pis/models/job.dart';

class JobApiService {
  DatabaseReference _counterRef;
  DatabaseReference _jobRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = FirebaseDatabase();
  int _counter;
  DatabaseError error;

  static final JobApiService _instance = JobApiService.internal();

  JobApiService.internal();

  factory JobApiService() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counterJobOrder');
    // Demonstrates configuring the database directly

    _jobRef = database.reference().child('jobOrder');
    database
        .reference()
        .child('counterJobOrder')
        .once()
        .then((DataSnapshot snapshot) {
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

  DatabaseReference getJob() {
    return _jobRef;
  }

  addJob(JobOrder jobOrder) async {
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _jobRef.push().set(<String, String>{
        "custId": "" + jobOrder.custid,
        "empId": "" + jobOrder.empid,
        "dateNow": "" +jobOrder.dateNow,
        "dateInstall": "" + jobOrder.dateInstall,
        "status": "" + jobOrder.status,
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

  void deleteJob(JobOrder jobOrder) async {
    await _jobRef.child(jobOrder.id.toString()).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateJob(JobOrder jobOrder) async {
    await _jobRef.child(jobOrder.id.toString()).update({
      "custId": "" + jobOrder.custid,
      "empId": "" + jobOrder.empid,
      "dateNow": "" + jobOrder.dateNow,
      "dateInstall": "" + jobOrder.dateInstall,
      "status": "" + jobOrder.status,
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void dispose() {
    // _messagesSubscription.cancel();
    // _counterSubscription.cancel();
  }
}
