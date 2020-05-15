// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return Employee(
    employeeId: json['EmpId'] as int,
    firstName: json['First_name'] as String,
    lastName: json['Last_name'] as String,
    gender: json['Gender'] as String,
    status: json['status'] as String,
    phone: json['Phone'] as String,
    dob: json['DOB'] as String,
    email: json['Email'] as String,
    id: json['_id'] as String,
  );
}

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      '_id': instance.id,
      'EmpId': instance.employeeId,
      'First_name': instance.firstName,
      'Last_name': instance.lastName,
      'Gender': instance.gender,
      'DOB': instance.dob,
      'status': instance.status,
      'Phone': instance.phone,
      'Email': instance.email,
    };
