import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/methods/navigate_to.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/navigate_from_login/navigate_from_login_states.dart';
import 'package:booking/services/auth_storage.dart';
import 'package:booking/types/user_role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigateFromLoginCubit extends Cubit<NavigateFromLoginStates> {
  NavigateFromLoginCubit() : super(NavigateInitial(role: ''));
  void routeFromLogin(
    BuildContext context,
    GlobalKey<NavigatorState> navigatorKey,
  ) async {
    // await AuthStorage().deleteAllData();
    final String? role = await AuthStorage().readData("role");
    emit(NavigateLoading());
    if (role != null && role.isNotEmpty) {
      emit(NavigateTo(role: role));
      if (state.role == UserRole.tenant.name) {
        await navigatorKey.currentState!.pushReplacementNamed(tenantView);
      } else if (state.role == UserRole.landlord.name) {
        await navigatorKey.currentState!.pushReplacementNamed(
          landlordDashBoard,
        );
      }
    } else {
      await navigatorKey.currentState!.pushReplacementNamed(loginView);
    }
    printRed("text");
  }
}
