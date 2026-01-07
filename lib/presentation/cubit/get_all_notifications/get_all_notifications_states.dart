import 'package:booking/types/notificate_type.dart';

class GetAllNotificationsStates {}

class GetAllNotificationsInitial extends GetAllNotificationsStates {}

class GetAllNotificationsLoading extends GetAllNotificationsStates {}

class GetAllNotificationsSucceful extends GetAllNotificationsStates {
  final List<NotificateType> notifications;

  GetAllNotificationsSucceful({required this.notifications});
}

class GetAllNotificationsFailed extends GetAllNotificationsStates {
  final String message;

  GetAllNotificationsFailed({required this.message});
}
