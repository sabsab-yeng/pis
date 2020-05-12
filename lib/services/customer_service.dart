import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:pis/models/customer.dart';

class CustomerUtil {
  DatabaseReference _counterRef;
  DatabaseReference _customerRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = FirebaseDatabase();
  int _counter;
  DatabaseError error;

  static final CustomerUtil _instance =
     CustomerUtil.internal();

  CustomerUtil.internal();

  factory CustomerUtil() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counterCustomer');
    // Demonstrates configuring the database directly

    _customerRef = database.reference().child('customer');
    database.reference().child('counterCustomer').once().then((DataSnapshot snapshot) {
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

  DatabaseReference getCustomer() {
    return _customerRef;
  }

  addCustomer(Customer customer) async {
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _customerRef.push().set(<String, String>{
        "firstname": "" + customer.firstname,
        "lastname": "" + customer.lastname,
        "gender": "" + customer.gender,
        "phone": "" + customer.phone,
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

  void deleteCustomer(Customer customer) async {
    await _customerRef.child(customer.id.toString()).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateCustomer(Customer customer) async {
    await _customerRef.child(customer.id.toString()).update({
      "firstname": "" + customer.firstname,
      "lastname": "" + customer.lastname,
      "gender": "" + customer.gender,
      "phone": "" + customer.phone,
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void dispose() {
    // _messagesSubscription.cancel();
    // _counterSubscription.cancel();
  }
}