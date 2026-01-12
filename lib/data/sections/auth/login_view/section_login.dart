import 'package:booking/data/models/auth/login/login_form.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/keys_localization/auth_key.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SectionLogin extends StatelessWidget {
  const SectionLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(rem(1)),
      decoration: BoxDecoration(
        color: context.appTheme.thirdly,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(rem(1)),
          topRight: Radius.circular(rem(1)),
        ),
      ),
      child: ListView(
        children: [
          Text(
            AuthKeys.loginTitlePage.tr(),
            style: TextStyle(fontSize: rem(2.5), fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: rem(1)),
            child: Text(
              AuthKeys.loginTextGuide.tr(),
              style: TextStyle(
                fontSize: rem(1),
                color: context.appTheme.secondary,
              ),
            ),
          ),
          LoginForm(),
        ],
      ),
    );
  }
}
