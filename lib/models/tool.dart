import 'package:firebase_database/firebase_database.dart';
 
class Tool {
  String _id;
  String _title;
  bool selected = false;
 
  Tool(this._id, this._title, {this.selected});
 
  Tool.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
  }
 
  String get id => _id;
  String get title => _title;
 
  Tool.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _title = snapshot.value['title'];
  }
}