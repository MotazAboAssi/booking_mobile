import 'package:booking/data/models/auth/form/input_field_form.dart';
import 'package:booking/data/models/auth/login/button_sign_in.dart';
import 'package:booking/presentation/cubit/auth/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isSecure = ValueNotifier<bool>(false);
    final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        spacing: 20,
        children: [
          // Email Input
          InputFieldForm(
            name: "phone",
            hintText: "+963*********",
            labelTeaxt: "Phone No",
            validatorsProps: [
              FormBuilderValidators.phoneNumber(
                // regex: RegExp(r"^\+963[0-9]{9}$"),
              ),
            ],
          ),
          // Password Input
          ValueListenableBuilder(
            valueListenable: isSecure,
            builder: (context, value, child) {
              return InputFieldForm(
                name: "password",
                hintText: "********",
                labelTeaxt: "Password",
                validatorsProps: [
                  // FormBuilderValidators.password()
                ],
                suffixIcon: IconButton(
                  onPressed: () {
                    isSecure.value = !isSecure.value;
                  },
                  icon: Icon(
                    isSecure.value ? Icons.remove_red_eye : Icons.remove,
                  ),
                ),
                obscureText: !isSecure.value,
              );
            },
          ),
          // Button Sign in
          BlocProvider(
            create: (_) => LoginCubit(),
            child: ButtonSignIn(formKey: formKey),
          ),
        ],
      ),
    );
  }
}
