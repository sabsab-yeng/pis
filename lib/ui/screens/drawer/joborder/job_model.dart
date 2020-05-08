class Job {
  int _id;
  String _custid;
  String _empid;
  String _datenow;
  String _dateinstall;
  String _status;
  String _description;

  Job(this._custid, this._empid, this._datenow, this._dateinstall, this._status,
      this._description);

  Job.map(dynamic obj) {
    this._id = obj['id'];
    this._custid = obj['custid'];
    this._empid = obj['empid'];
    this._datenow = obj['datenow'];
    this._dateinstall = obj['dateinstall'];
    this._status = obj['status'];
    this._description = obj['description'];
  }

  int get id => _id;
  String get custid => _custid;
  String get empid => _empid;
  String get datenow => _datenow;
  String get dateinstall => _dateinstall;
  String get status => _status;
  String get description => _description;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['custid'] = _custid;
    map['empid'] = _empid;
    map['datenow'] = _datenow;
    map['dateinstall'] = _dateinstall;
    map['status'] = _status;
    map['description'] = _description;

    return map;
  }

  Job.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._custid = map['custid'];
    this._empid = map['empid'];
    this._datenow = map['datenow'];
    this._dateinstall = map['dateinstall'];
    this._status = map['status'];
    this._description = map['description'];
  }
}
