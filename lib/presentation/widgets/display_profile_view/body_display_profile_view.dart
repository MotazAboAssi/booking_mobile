import 'package:booking/data/sections/display_profile_user_view/section_group_of_input_field.dart';
import 'package:booking/data/sections/display_profile_user_view/section_image_picker_profile.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/types/user_register_type.dart';
import 'package:flutter/material.dart';

class BodyDisplayProfileView extends StatelessWidget {
  const BodyDisplayProfileView({
    super.key,
    required this.user,
  });

  final UserRegisterType? user;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SectionImagePickerProfile(image: user?.profileImage ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: rem(1)),
          child: SectionGroupOfInputField(user: user),
        ),
      ],
    );
  }
}