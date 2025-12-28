import 'dart:io';

import 'package:booking/helper/constant/form_keys/registers_keys.dart';
import 'package:booking/types/user_role.dart';

class UserRegisterType {
  final int? _id;
  final String _phone;
  final String? _password;
  final String _firstName;
  final String _lastName;
  final File _profileImage;
  final File _idImage;
  final UserRole _role;
  final DateTime _birthday;
  final int _balance;

  UserRegisterType({
    required String phone,
    String? password,
    required String firstName,
    required String lastName,
    required File profileImage,
    required File idImage,
    required UserRole role,
    required DateTime birthday,
    required int balance,
    int? id,
  }) : _phone = phone,
       _password = password,
       _firstName = firstName,
       _lastName = lastName,
       _profileImage = profileImage,
       _idImage = idImage,
       _role = role,
       _birthday = birthday,
       _balance = balance,
       _id = id;

  String get phone => _phone;
  String? get password => _password;
  String get firstName => _firstName;
  String get lastName => _lastName;
  File get profileImage => _profileImage;
  File get idImage => _idImage;
  UserRole get role => _role;
  DateTime get birthday => _birthday;
  int get balance => _balance;
  int? get id => _id;

  factory UserRegisterType.fromJson(Map<String, dynamic> json) {
    // final json = data["data"]["0"];
    // log(json.toString());
    return UserRegisterType(
      id: json['id'],
      phone: json['phone'],
      password: json['password'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileImage: File(json['profile_image']),
      idImage: File(json['id_image']),
      role: json['role'] == 'landlord' ? UserRole.landlord : UserRole.tenant,
      birthday: DateTime.parse(json['birthday']),
      balance: json[balanceKey],
    );
  }
}
