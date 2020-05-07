class Employee {
  int id;
  String fname;
  String lname;
  String gender;
  String phone;
  String jobId;

 
  Employee(this.id, this.fname, this.lname, this.phone, this.gender, this.jobId);
 
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': fname,
      'lname' : lname,
      'gender' : gender,
      'phone' : phone,
      'jobId' : jobId,
    };
    return map;
  }
 
  Employee.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    fname = map['name'];
    lname = map['lname'];
    gender = map['gender'];
    phone = map['phone'];
    jobId = map['jobId'];
  }
}



class Note {
  int _id;
  String _title;
  String _description;
 
  Note(this._title, this._description);
 
  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._description = obj['description'];
  }
 
  int get id => _id;
  String get title => _title;
  String get description => _description;
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
 
    return map;
  }
 
  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
  }
}