import 'dart:io';

import 'package:booking/helper/constant/images.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
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

class SectionImagePickerProfile extends StatelessWidget {
  final File? image;

  const SectionImagePickerProfile({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    const double radiusProfile = 4;
    return CircleAvatar(
      radius: rem(radiusProfile),
      backgroundColor: Colors.black,
      child: CircleAvatar(
        radius: rem(radiusProfile - 0.1),
        backgroundImage: image == null
            ? AssetImage(anonymousManAvatar)
            : fetchImageFromDB(image!.path),
      ),
    );
  }
}

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
        Card(icon: Icons.phone, title: '+9639${user?.phone}'),
        Card(icon: Icons.person, title: '${user?.firstName} ${user?.lastName}'),
        Card(icon: Icons.date_range, title: '${user?.birthday}'),
      ],
    );
  }
}

class Card extends StatelessWidget {
  final IconData icon;
  final String title;
  const Card({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Center(child: Text(title)),
    );
  }
}
