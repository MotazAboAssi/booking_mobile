import 'dart:io';

import 'package:booking/data/models/auth/register/button_sign_up.dart';
import 'package:booking/data/sections/auth/register_view/section_group_of_input_field.dart';
import 'package:booking/data/sections/auth/register_view/section_image_picker_profile.dart';
import 'package:booking/data/sections/auth/register_view/section_pick_image_picture_id.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/methods/navigate_to.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/auth/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late GlobalKey<FormBuilderState> formKey;

  File? imageProfile, imageIDCard;

  void setImageProfile(File? image) {
    setState(() {
      imageProfile = image;
    });
  }

  void setImageIDCard(File? image) {
    setState(() {
      imageIDCard = image;
    });
  }

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormBuilderState>();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(rem(2)),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FormBuilder(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: ListView(
                    children: [
                      SectionImagePickerProfile(
                        constraints: constraints,
                        fun: setImageProfile,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: rem(1)),
                        child: SectionGroupOfInputField(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: rem(1)),
                        child: SectionPickImagePictureID(fun: setImageIDCard),
                      ),
                      BlocProvider(
                        create: (_) => RegisterCubit(),
                        child: ButtonSignUp(
                          formKey: formKey,
                          imageProfile: imageProfile,
                          imageIDCard: imageIDCard,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Do you have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: rem(1),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, loginView);
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: rem(1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
