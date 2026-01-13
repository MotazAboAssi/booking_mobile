import 'dart:async';
import 'dart:isolate';

import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/keys_localization/tenant_key.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/get_all_notifications/get_all_notifications_cubit.dart';
import 'package:booking/presentation/cubit/get_all_notifications/get_all_notifications_states.dart';
import 'package:booking/presentation/cubit/tenant_view/tenant_view_cubit.dart';
import 'package:booking/presentation/widgets/button_refresh.dart';
import 'package:booking/presentation/widgets/custome_bottom_navigation_bar_for_tenant.dart';
import 'package:booking/presentation/widgets/tenant_view/app_bar_tenant_view.dart';
import 'package:booking/presentation/widgets/tenant_view/body_tenant_view.dart';
import 'package:booking/services/http_request.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TenantView extends StatefulWidget {
  const TenantView({super.key});

  @override
  State<TenantView> createState() => _TenantViewState();
}

class _TenantViewState extends State<TenantView> {
  late final Timer _timer;

  void initState() {
    super.initState();
    context.read<GetAllNotificationsCubit>().fetch();

    _timer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => context.read<GetAllNotificationsCubit>().fetch(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomeBottomNavigationBarForTenant(index: 0),
      floatingActionButton: ButtonRefresh(
        action: () async {
          final cubit = context.read<TenantViewCubit>();
          await cubit.getAllApartmentForTenant();
        },
      ),

      appBar: appBarTenantView(context),

      onEndDrawerChanged: (isOpened) async {
        if (!isOpened) {
          await HttpRequest().clearAllNotifications();
          printWhite('Done clear');
        } else {
          final cubit = BlocProvider.of<GetAllNotificationsCubit>(context);
          await cubit.fetch();
        }
      },

      endDrawer: Drawer(
        backgroundColor: context.appTheme.thirdly,
        child: SafeArea(
          child: Column(
            children: [
              Text(
                TenantKeys.notificationLable.tr(),
                style: TextStyle(
                  fontSize: rem(1.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child:
                    BlocBuilder<
                      GetAllNotificationsCubit,
                      GetAllNotificationsStates
                    >(
                      builder: (context, state) {
                        if (state is GetAllNotificationsSucceful) {
                          return state.notifications.isEmpty
                              ? Center(
                                  child: Text(
                                    TenantKeys.notificationEmptyStateMessage
                                        .tr(),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: state.notifications.length,
                                  padding: EdgeInsets.all(rem(1)),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                        String message =
                                            state.notifications[index].message;
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            bottom: rem(1),
                                          ),
                                          child: ListTile(
                                            tileColor:
                                                context.appTheme.secondary,
                                            iconColor: context.appTheme.thirdly,
                                            textColor: context.appTheme.thirdly,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadiusGeometry.circular(
                                                    rem(1),
                                                  ),
                                              side: BorderSide(
                                                color: context.appTheme.thirdly,
                                              ),
                                            ),
                                            leading: Icon(Icons.apartment),
                                            title: Text(message),
                                          ),
                                        );
                                      },
                                );
                        }
                        return Center(
                          child: Text(
                            TenantKeys.notificationEmptyStateMessage.tr(),
                          ),
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
      body: BodyTenantView(),
    );
  }
}
