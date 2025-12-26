import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/navigate_to.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/tenant_view/tenant_view_cubit.dart';
import 'package:booking/presentation/widgets/tenant_view/app_bar_tenant_view.dart';
import 'package:booking/presentation/widgets/tenant_view/body_tenant_view.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TenantView extends StatelessWidget {
  const TenantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: fourthly,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.favorite, title: 'Favorite'),
          TabItem(icon: Icons.settings, title: 'Settings'),
        ],
        onTap: (index) {
          if (index == 0) navigateTo(context, tenantView);
          if (index == 1) navigateTo(context, favoriteApartments);
          if (index == 2) navigateTo(context, tenantView);
        },
                initialActiveIndex: 0,

      ),
      floatingActionButton: InkWell(
        onTap: () async {
          final cubit = context.read<TenantViewCubit>();
          await cubit.getAllApartmentForTenant();
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: rem(0.5)),
          child: CircleAvatar(
            backgroundColor: fourthly,
            child: Icon(Icons.refresh, color: thirdly),
          ),
        ),
      ),

      appBar: appBarTenantView(),
      body: BodyTenantView(),
    );
  }
}
