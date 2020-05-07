
class Employee {
  int _id;
  String _firstName;
  String _lastName;
  String _gender;
  String _phone;
  String _jobId;
 
  Employee(this._firstName,this._lastName, this._gender, this._phone, this._jobId);
 
  Employee.map(dynamic obj) {
    this._id = obj['id'];
    this._firstName = obj['firstname'];
    this._lastName = obj['lastname'];
    this._gender = obj['gender'];
    this._phone = obj['phone'];
    this._jobId = obj['jobId'];
  }
 
  int get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get gender => _gender;
  String get phone => _phone;
  String get jobId => _jobId;
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['firstname'] = _firstName;
    map['lastname'] = _lastName;
    map['gender'] = _gender;
    map['phone'] = _phone;
    map['jobId'] = _jobId;
 
    return map;
  }
 
  Employee.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._firstName = map['firstname'];
    this._lastName = map['lastname'];
    this._gender = map['gender'];
    this._phone = map['phone'];
    this._jobId = map['jobId'];
  }
}