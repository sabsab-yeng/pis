import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  @JsonKey(name: '_id', nullable: false)
  String id;

  @JsonKey(name: 'CustID', nullable: false)
  int customerId;

  @JsonKey(name: 'First_name', nullable: false)
  String firstName;

  @JsonKey(name: 'Last_name', nullable: false)
  String lastName;

  @JsonKey(name: 'Gender', nullable: false)
  String gender;

  @JsonKey(name: 'googleMap', nullable: false)
  int googleMap;

  @JsonKey(name: 'Phone', nullable: false)
  String phone;

  @JsonKey(name: 'Email', nullable: false)
  String email;

  Customer(
      {this.customerId,
      this.firstName,
      this.lastName,
      this.gender,
      this.googleMap,
      this.phone,
      this.email,
      this.id});

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  String toString() {
    return [
      this.customerId,
      this.firstName,
      this.lastName,
      this.gender,
      this.googleMap,
      this.phone,
      this.email,
      this.id
    ].join(",");
  }
}
