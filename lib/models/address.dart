import 'dart:convert';

class Address {
  final String pincode;
  final String addressType;
  final String address;
  final String phone;

  const Address({
    required this.pincode,
    required this.addressType,
    required this.address,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'pincode': pincode,
      'addressType': addressType,
      'address': address,
      'phone': phone,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      pincode: map['pincode'] ?? '',
      addressType: map['addressType'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));
}
