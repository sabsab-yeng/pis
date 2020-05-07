
class Customer {
  int _id;
  String _firstName;
  String _gender;
  String _phone;
 
  Customer(this._firstName, this._gender, this._phone);
 
  Customer.map(dynamic obj) {
    this._id = obj['id'];
    this._firstName = obj['firstname'];
    this._gender = obj['gender'];
  }
 
  int get id => _id;
  String get firstName => _firstName;
  String get gender => _gender;
  String get phone => _phone;
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['firstname'] = _firstName;
    map['gender'] = _gender;
    map['phone'] = _phone;
 
    return map;
  }
 
  Customer.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._firstName = map['firstname'];
    this._gender = map['gender'];
    this._phone = map['phone'];
  }
}