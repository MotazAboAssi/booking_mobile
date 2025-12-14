class UserLoginType {
  final String _phone;
  final String _password;

  UserLoginType({required String phone, required String password})
    : _phone = phone,
      _password = password;

  String get phone => _phone;
  String get password => _password;

  factory UserLoginType.empty() {
    return UserLoginType(phone: '', password: '');
  }

  factory UserLoginType.simple() {
    return UserLoginType(phone: '11111111', password: '11111111');
  }

  factory UserLoginType.fromJson(Map<String, dynamic> json) {
    return UserLoginType(phone: json['phone'], password: json['password']);
  }
}
