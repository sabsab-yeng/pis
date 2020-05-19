import 'package:firebase_database/firebase_database.dart';
import 'package:pis/enum/enum.dart';

class JobOrder {
  String _id;
  String _custId;
  String _empId;
  String _dateNow;
  String _dateInstall;
  String _status;

  JobOrder(this._id, this._custId, this._empId, this._dateNow,
      this._dateInstall, this._status);

  String get custid => _custId;

  String get empid => _empId;

  String get dateNow => _dateNow;

  String get dateInstall => _dateInstall;

  String get status => _status;

  String get id => _id;

  JobOrder.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _custId = snapshot.value['custId'];
    _empId = snapshot.value['empId'];
    _dateNow = snapshot.value['dateNow'];
    _dateInstall = snapshot.value['dateInstall'];
    _status = snapshot.value['status'];
  }

  // JobOrder.map(dynamic obj) {
  //   this._id = obj['id'];
  //   this._custId = obj['custId'];
  //   this._empId = obj['empId'];

  //   this._dateNow = obj['dateNow'];
  //   this._dateInstall = obj['dateInstall'];
  //   this._status = obj['status'];
  // }


  // JobStatus getJobStatus() {
  //   switch (status) {
  //     case 0:
  //       return JobStatus.New;
  //     case 1:
  //       return JobStatus.SiteSurvey;
  //     case 2:
  //       return JobStatus.MaterialRequest;
  //     case 3:
  //       return JobStatus.InstallationExecution;
  //     case 4:
  //       return JobStatus.Testing;
  //     case 5:
  //       return JobStatus.TechReport;
  //     case 6:
  //       return JobStatus.CustomerConfirm;
  //   }
  // }
}
