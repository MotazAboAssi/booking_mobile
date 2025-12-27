import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/widgets/display_profile_view/body_display_profile_view.dart';
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
            child: BodyDisplayProfileView(user: user),
          ),
        ),
      ),
    );
  }
}
