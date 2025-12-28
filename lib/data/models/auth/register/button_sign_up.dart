import 'dart:io';
import 'package:booking/data/models/auth/form/custom_snak_bar.dart';
import 'package:booking/helper/constant/form_keys/registers_keys.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/navigate_to.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/auth/register/register_cubit.dart';
import 'package:booking/presentation/cubit/auth/register/register_state_cubit.dart';
import 'package:booking/types/user_register_type.dart';
import 'package:booking/types/user_role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ButtonSignUp extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final File? imageProfile;
  final File? imageIDCard;

  const ButtonSignUp({
    super.key,
    required this.formKey,
    this.imageProfile,
    this.imageIDCard,
  });

  @override
  Widget build(BuildContext context) {
    final role = (ModalRoute.of(context)?.settings.arguments as Map)["role"];
    return ElevatedButton(
      onPressed: context.select<RegisterCubit, void Function()?>((value) {
        final state = value.state;
        final form = formKey.currentState;
        if (state is RegisterSuccessfuly ||
            state is UnderRegistrationInRegister) {
          return null;
        } else {
          return () async {
            if (form != null) {
              form.save();
              if (form.validate()) {
                final Map<String, dynamic> input = form.value;
                final cubit = BlocProvider.of<RegisterCubit>(context);
                final UserRegisterType user = UserRegisterType(
                  phone: input[phoneKey].toString().substring(5),
                  password: input[passwordKey],
                  firstName: input[firstNameKey],
                  lastName: input[lastNameKey],
                  profileImage: File(imageProfile?.path ?? ""),
                  idImage: File(imageIDCard?.path ?? ""),
                  role: role == "tenant" ? UserRole.tenant : UserRole.landlord,
                  birthday: input[dateOfBirthKey],
                  balance: role == UserRole.tenant.name
                      ? int.parse(input[balanceKey])
                      : 0,
                );
                try {
                  await cubit.register(user);
                } catch (e) {
                  printRed(e.toString());
                }
              }
              // form.patchValue({"email": "mo@dd.c", "password": "123cvbASD/*-"});
            }
          };
        }
      }),

      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: context.select<RegisterCubit, Color?>((value) {
          final state = value.state;
          if (state is RegisterSuccessfuly) {
            return Colors.green;
          } else if (state is UnderRegistrationInRegister) {
            return Colors.grey;
          } else {
            return null;
          }
        }),
        padding: EdgeInsetsGeometry.zero,
        alignment: Alignment.center,
        fixedSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.07,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(5),
        ),

        backgroundColor: Colors.lightBlue,
      ),

      child: BlocConsumer<RegisterCubit, RegisterStateCubit>(
        builder: (context, state) {
          if (state is RegisterFailed || state is InitialRegister) {
            return Text("Sign up", style: TextStyle(color: thirdly));
          } else if ((state is RegisterSuccessfuly)) {
            return Center(
              child: Icon(Icons.check_rounded, color: Colors.white, size: 25),
            );
          }
          return SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(color: Colors.white),
          );
        },
        listener: (c, state) async {
          if ((state is RegisterSuccessfuly)) {
            customSnakBar(
              context: c,
              color: Colors.green,
              message: "✅ DONE ,Requist to Join",
            );
            await Future.delayed(Duration(seconds: 3));
            navigateTo(context, loginView);
          } else if (state is RegisterFailed) {
            customSnakBar(
              context: c,
              color: Colors.red,
              message: state.errorMessage,
            );
          }
        },
      ),
    );
  }
}
