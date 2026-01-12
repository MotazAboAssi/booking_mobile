import 'package:booking/data/models/auth/role_selection_view/role_card_model.dart';
import 'package:booking/helper/keys_localization/auth_key.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SectionDetermineRole extends StatelessWidget {
  const SectionDetermineRole({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: rem(1.5),
      children: [
        RoleCardModel(
          icon: Icons.key,
          role: 'tenant',
          permissions: AuthKeys.roleTenantDesc.tr(), title: AuthKeys.roleTenantName.tr() ,
        ),
        RoleCardModel(
          icon: Icons.real_estate_agent,
          role: 'landlord',
          permissions: AuthKeys.roleLandlordDesc.tr(), title: AuthKeys.roleLandlordName.tr(),
        ),
      ],
    );
  }
}