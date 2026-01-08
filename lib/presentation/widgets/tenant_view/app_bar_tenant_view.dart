import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/get_all_notifications/get_all_notifications_cubit.dart';
import 'package:booking/presentation/cubit/get_all_notifications/get_all_notifications_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppBar appBarTenantView(BuildContext context) {
  int count = 0;
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Icon(
        Icons.apartment,
        color: context.appTheme.primarye,
        size: rem(3),
      ),
    ),
    title: Text(
      'SYRent',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: context.appTheme.primarye,
      ),
    ),
    actionsPadding: const EdgeInsets.only(right: 10),

    actions: [
      Builder(
        builder: (context) {
          return InkWell(
            onTap: () {
              return Scaffold.of(context).openEndDrawer();
            },
            child:
                BlocBuilder<
                  GetAllNotificationsCubit,
                  GetAllNotificationsStates
                >(
                  builder: (context, state) {
                    if (state is GetAllNotificationsSucceful) {
                      count = state.count;
                    }
                    return Stack(
                      children: [
                        Icon(
                          Icons.notifications,
                          size: rem(2),
                          color: Colors.amber,
                        ),
                        Positioned(
                          width: count == 0 ? 0 : null,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: context.appTheme.error,
                            minRadius: 5,
                            maxRadius: 8,
                            child: Text(
                              '$count',
                              style: TextStyle(
                                color: context.appTheme.thirdly,
                                fontSize: rem(0.45),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
          );
        },
      ),
    ],
  );
}
