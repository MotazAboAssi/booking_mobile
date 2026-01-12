import 'dart:developer';

import 'package:booking/data/models/auth/form/custom_snak_bar.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/keys_localization/auth_key.dart';
import 'package:booking/helper/methods/navigate_to.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/auth/login/login_cubit.dart';
import 'package:booking/presentation/cubit/auth/login/login_state_cubit.dart';
import 'package:booking/services/auth_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ButtonSignIn extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const ButtonSignIn({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: context.select<LoginCubit, void Function()?>((value) {
        final state = value.state;
        final form = formKey.currentState;
        if (state is LoginSuccessfuly || state is UnderRegistrationLogIn) {
          return null;
        } else {
          return () async {
            if (form != null) {
              form.save();
              if (form.validate()) {
                final Map<String, dynamic> input = form.value;
                final cubit = BlocProvider.of<LoginCubit>(context);
                try {
                  await cubit.login(input);
                  final String? role = await AuthStorage().readData("role");
                  if (role == "tenant") {
                    navigateTo(context, tenantView);
                  } else {
                    navigateTo(context, landlordDashBoard);
                  }
                } catch (e) {
                  log(e.toString());
                }
              }
            }
          };
        }
      }),

      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: context.select<LoginCubit, Color?>((value) {
          final state = value.state;
          if (state is LoginSuccessfuly) {
            return context.appTheme.success;
          } else if (state is UnderRegistrationLogIn) {
            return context.appTheme.secondary;
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

        backgroundColor: context.appTheme.fourthly,
      ),

      child: BlocConsumer<LoginCubit, LoginStateCubit>(
        builder: (context, state) {
          if (state is LoginFailed || state is InitialLogIn) {
            return Text(
              AuthKeys.loginButtonSubmit.tr(),
              style: TextStyle(
                color: context.appTheme.thirdly,
                fontSize: rem(1.5),
              ),
            );
          } else if ((state is LoginSuccessfuly)) {
            return Center(
              child: Icon(
                Icons.check_rounded,
                color: context.appTheme.thirdly,
                size: 25,
              ),
            );
          }
          return SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(color: context.appTheme.thirdly),
          );
        },
        listener: (context, state) {
          if ((state is LoginSuccessfuly)) {
            customSnakBar(
              context: context,
              color: context.appTheme.success,
              message:
                  "Welcome to back ${state.user.firstName} ${state.user.lastName}",
            );
          } else if (state is LoginFailed) {
            customSnakBar(
              context: context,
              color: context.appTheme.error,
              message: state.errorMessage,
            );
          }
        },
      ),
    );
  }
}
