
import 'package:firebase_database/firebase_database.dart';

class Student{
  String fname;
  String lname;
  String age;
  String key;

  Student({this.fname, this.lname, this.age,this.key});
  Student.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        fname = snapshot.value["fname"],
        lname = snapshot.value["lname"],
        age = snapshot.value["age"];


  toJson() {
    return {
      "fname": fname,
      "lname": lname,
      "age": age
    };
  }
}