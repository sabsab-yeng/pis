import 'package:json_annotation/json_annotation.dart';

import 'customer.dart';
import 'employee.dart';

part 'job.g.dart';

@JsonSerializable()
class Job {
  @JsonKey(name: '_id', nullable: false)
  String id;

  @JsonKey(name: 'CustID', nullable: false)
  List<Customer> customer;

  @JsonKey(name: 'EmpID', nullable: false)
  List<Employee> employee;

  @JsonKey(name: 'Tool_ID', nullable: false)
  String toolId;

  @JsonKey(name: 'Install_Date', nullable: false)
  String installDate;

  @JsonKey(name: 'Status', nullable: false)
  String status;

  @JsonKey(name: 'Register_DATE', nullable: false)
  String registerDate;

  Job(
      {this.customer,
      this.employee,
      this.toolId,
      this.installDate,
      this.status,
      this.registerDate,
      this.id});

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
  Map<String, dynamic> toJson() => _$JobToJson(this);

  String toString() {
    return [
      this.customer,
      this.employee,
      this.toolId,
      this.installDate,
      this.status,
      this.registerDate,
      this.id
    ].join(",");
  }
}
