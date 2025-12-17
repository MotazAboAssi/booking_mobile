import 'dart:developer';
import 'package:booking/data/models/auth/form/custom_snak_bar.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/back_to.dart';
import 'package:booking/presentation/cubit/auth/register/register_cubit.dart';
import 'package:booking/presentation/cubit/auth/register/register_state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ButtonSignUp extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const ButtonSignUp({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
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
                if ((input["email"] ?? "").isEmpty ||
                    (input["user name"] ?? "").isEmpty ||
                    (input["configure password"] ?? "").isEmpty ||
                    (input["password"] ?? "").isEmpty) {
                  debugPrint(form.value.toString());
                  return;
                }
                final cubit = BlocProvider.of<RegisterCubit>(context);
                try {
                  await cubit.register(input);
                } catch (e) {
                  log(e.toString());
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
        listener: (context, state) async {
          if ((state is RegisterSuccessfuly)) {
            customSnakBar(
              context: context,
              state: state,
              color: Colors.green,
              message: '✅ Register Successfuly',
            );
            await Future.delayed(Duration(seconds: 3));
            backTo(context);
          } else if (state is RegisterFailed) {
            customSnakBar(
              context: context,
              state: state,
              color: Colors.red,
              message: state.errorMessage,
            );
          }
        },
      ),
    );
  }
}
