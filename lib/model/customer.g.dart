// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    customerId: json['CustID'] as int,
    firstName: json['First_name'] as String,
    lastName: json['Last_name'] as String,
    gender: json['Gender'] as String,
    googleMap: json['googleMap'] as int,
    phone: json['Phone'] as String,
    email: json['Email'] as String,
    id: json['_id'] as String,
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      '_id': instance.id,
      'CustID': instance.customerId,
      'First_name': instance.firstName,
      'Last_name': instance.lastName,
      'Gender': instance.gender,
      'googleMap': instance.googleMap,
      'Phone': instance.phone,
      'Email': instance.email,
    };
