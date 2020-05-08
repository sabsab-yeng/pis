
class Job {
  int _id;
  String _custID;
  String _empID;
  String _dateNow;
  String _dateInstall;
  String _status;
  // String _description;
 
  Job(this._custID,this._empID, this._dateNow, this._dateInstall, this._status);
 
  Job.map(dynamic obj) {
    this._id = obj['id'];
    this._custID = obj['custid'];
    this._empID = obj['empid'];
    this._dateNow = obj['datenow'];
    this._dateInstall = obj['datein'];
    this._status = obj['status'];
    // this._description = obj['desc'];
  }
 
  int get id => _id;
  String get custid => _custID;
  String get empid => _empID;
  String get datenow => _dateNow;
  String get dateInstall => _dateInstall;
  String get status => _status;
  // String get description => _description;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['custid'] = _custID;
    map['empid'] = _empID;
    map['datenow'] = _dateNow;
    map['datein'] = _dateInstall;
    map['status'] = _status;
    // map['desc'] = _description;
 
    return map;
  }
 
  Job.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._custID = map['custid'];
    this._empID = map['empid'];
    this._dateNow = map['datenow'];
    this._dateInstall = map['datein'];
    this._status = map['status'];
    // this._description = map['desc'];
  }
}