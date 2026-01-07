import 'package:booking/presentation/cubit/get_all_notifications/get_all_notifications_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAllNotificationsCubit extends Cubit<GetAllNotificationsStates> {
  GetAllNotificationsCubit() : super(GetAllNotificationsInitial());
  Future<void> fetch() async {
    try {
      emit(GetAllNotificationsLoading());
      await HttpRequest().getAllNotification();
      emit(GetAllNotificationsSucceful(notifications: []));
    } catch (e) {
      emit(GetAllNotificationsFailed(message: e.toString()));
    }
  }
}
