import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  @JsonKey(name: '_id', nullable: false)
  String id;

  @JsonKey(name: 'EmpId', nullable: false)
  int employeeId;

  @JsonKey(name: 'First_name', nullable: false)
  String firstName;

  @JsonKey(name: 'Last_name', nullable: false)
  String lastName;

  @JsonKey(name: 'Gender', nullable: false)
  String gender;

  @JsonKey(name: 'DOB', nullable: false)
  String dob;

  @JsonKey(name: 'status', nullable: false)
  String status;

  @JsonKey(name: 'Phone', nullable: false)
  String phone;

  @JsonKey(name: 'Email', nullable: false)
  String email;

  Employee(
      {this.employeeId,
      this.firstName,
      this.lastName,
      this.gender,
      this.status,
      this.phone,
      this.dob,
      this.email,
      this.id});

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

  String toString() {
    return [
      this.employeeId,
      this.firstName,
      this.lastName,
      this.gender,
      this.status,
      this.phone,
      this.dob,
      this.email,
      this.id
    ].join(",");
  }
}
