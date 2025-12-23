import 'package:booking/presentation/widgets/tenant_view/app_bar_tenant_view.dart';
import 'package:booking/presentation/widgets/tenant_view/body_tenant_view.dart';
import 'package:flutter/material.dart';

class TenantView extends StatelessWidget {
  const TenantView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(appBar: appBarTenantView(), body: BodyTenantView());
  }
}
