class NotificateType {
  final int id;
  final int userID;
  final String message;

  NotificateType({
    required this.id,
    required this.userID,
    required this.message,
  });

  factory NotificateType.fromJson(Map<String, dynamic> json) {
    return NotificateType(
      id: json['id'],
      userID: json['userID'],
      message: json['message'],
    );
  }

  factory NotificateType.empty() {
    return NotificateType(
      id: 0,
      userID: 0,
      message: '',
    );
  }
}
