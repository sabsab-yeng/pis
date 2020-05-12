import 'package:firebase_database/firebase_database.dart';

class Employee {

  String _id;
  String _fistname;
  String _lastname;
  String _gender;
  String _phone;

  Employee(this._id,this._fistname, this._lastname, this._gender, this._phone);

  String get firstname => _fistname;

  String get lastname => _lastname;

  String get gender => _gender;

  String get phone => _phone;

  String get id => _id;

  Employee.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _fistname = snapshot.value['firstname'];
    _lastname = snapshot.value['lastname'];
    _gender = snapshot.value['gender'];
    _phone = snapshot.value['phone'];
  }
}