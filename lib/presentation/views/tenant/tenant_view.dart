import 'package:booking/presentation/cubit/tenant_view/tenant_view_cubit.dart';
import 'package:booking/presentation/widgets/button_refresh.dart';
import 'package:booking/presentation/widgets/custome_bottom_navigation_bar.dart';
import 'package:booking/presentation/widgets/tenant_view/app_bar_tenant_view.dart';
import 'package:booking/presentation/widgets/tenant_view/body_tenant_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TenantView extends StatelessWidget {
  const TenantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomeBottomNavigationBar(index: 0,),
      floatingActionButton: ButtonRefresh(
        action: () async {
          final cubit = context.read<TenantViewCubit>();
          await cubit.getAllApartmentForTenant();
        },
      ),

      appBar: appBarTenantView(),
      body: BodyTenantView(),
    );
  }
}


