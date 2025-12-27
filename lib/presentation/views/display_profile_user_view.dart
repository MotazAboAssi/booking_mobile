import 'package:booking/data/sections/display_profile_user_view/section_group_of_input_field.dart';
import 'package:booking/data/sections/display_profile_user_view/section_image_picker_profile.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/types/user_register_type.dart';
import 'package:flutter/material.dart';

class DisplayProfileUserView extends StatelessWidget {
  final UserRegisterType? user;
  const DisplayProfileUserView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LandLord"), centerTitle: true),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(rem(2)),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return ListView(
                  children: [
                    SectionImagePickerProfile(image: user?.profileImage),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: rem(1)),
                      child: SectionGroupOfInputField(user: user),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
