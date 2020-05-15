// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) {
  return Job(
    customer: (json['CustID'] as List)
        .map((e) => Customer.fromJson(e as Map<String, dynamic>))
        .toList(),
    employee: (json['EmpID'] as List)
        .map((e) => Employee.fromJson(e as Map<String, dynamic>))
        .toList(),
    toolId: json['Tool_ID'] as String,
    installDate: json['Install_Date'] as String,
    status: json['Status'] as String,
    registerDate: json['Register_DATE'] as String,
    id: json['_id'] as String,
  );
}

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      '_id': instance.id,
      'CustID': instance.customer,
      'EmpID': instance.employee,
      'Tool_ID': instance.toolId,
      'Install_Date': instance.installDate,
      'Status': instance.status,
      'Register_DATE': instance.registerDate,
    };
