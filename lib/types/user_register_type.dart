import 'dart:developer';

import 'package:image_picker/image_picker.dart';

enum UserRole { landlord, tenant }

class UserRegisterType {
  final int? _id;
  final String _phone;
  final String? _password;
  final String _firstName;
  final String _lastName;
  final XFile _profileImage;
  final XFile _idImage;
  final UserRole _role;
  final DateTime _birthday;

  UserRegisterType({
    required String phone,
    String? password,
    required String firstName,
    required String lastName,
    required XFile profileImage,
    required XFile idImage,
    required UserRole role,
    required DateTime birthday,
    int? id,
  }) : _phone = phone,
       _password = password,
       _firstName = firstName,
       _lastName = lastName,
       _profileImage = profileImage,
       _idImage = idImage,
       _role = role,
       _birthday = birthday,
       _id = id;

  String get phone => _phone;
  String? get password => _password;
  String get firstName => _firstName;
  String get lastName => _lastName;
  XFile get profileImage => _profileImage;
  XFile get idImage => _idImage;
  UserRole get role => _role;
  DateTime get birthday => _birthday;
  int? get id => _id;

  factory UserRegisterType.empty() {
    return UserRegisterType(
      id: 0,
      phone: '',
      password: '',
      firstName: '',
      lastName: '',
      profileImage: XFile(''),
      idImage: XFile(''),
      role: UserRole.tenant,
      birthday: DateTime(2000, 1, 1),
    );
  }

  factory UserRegisterType.simple() {
    return UserRegisterType(
      phone: '11111111',
      password: '11111111',
      firstName: 'John',
      lastName: 'Doe',
      profileImage: XFile('/home/motaz/Pictures/test.png'),
      idImage: XFile('/home/motaz/Pictures/test.png'),
      role: UserRole.tenant,
      birthday: DateTime(1990, 2, 1),
    );
  }

  factory UserRegisterType.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return UserRegisterType(
      id: json['id'],
      phone: json['phone'],
      password: json['password'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileImage: XFile(json['profile_image']),
      idImage: XFile(json['id_image']),
      role: json['role'] == 'landlord' ? UserRole.landlord : UserRole.tenant,
      birthday: DateTime.parse(json['birthday']),
    );
  }
}
