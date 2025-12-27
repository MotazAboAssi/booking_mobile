import 'package:booking/helper/methods/rem.dart';
import 'package:booking/types/user_register_type.dart';
import 'package:flutter/material.dart';
import 'package:booking/data/models/display_profile_user_view/card.dart';

class SectionGroupOfInputField extends StatelessWidget {
  final UserRegisterType? user;
  const SectionGroupOfInputField({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: rem(1),
      children: [
        CardInfo(icon: Icons.phone, title: '+9639${user?.phone}'),
        CardInfo(icon: Icons.person, title: '${user?.firstName} ${user?.lastName}'),
        CardInfo(icon: Icons.date_range, title: '${user?.birthday.toLocal()}'.split(' ')[0]),
      ],
    );
  }
}