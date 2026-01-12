import 'package:booking/data/sections/auth/role_selection_view/section_determine_role.dart';
import 'package:booking/data/sections/auth/role_selection_view/section_logo_and_description.dart';
import 'package:booking/helper/keys_localization/auth_key.dart';
import 'package:booking/helper/methods/back_to.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RoleSelectionView extends StatelessWidget {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: rem(1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: rem(1),
                  children: [
                    SectionLogoAndDescription(),
                    SectionDetermineRole(),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AuthKeys.roleFooterQuestion.tr()),
                  TextButton(
                    onPressed: () {
                      backTo(context);
                    },
                    child: Text(AuthKeys.roleFooterActionLink.tr()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}