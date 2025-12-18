import 'package:booking/data/models/auth/form/input_field_form.dart';
import 'package:booking/data/models/auth/register/button_sign_up.dart';
import 'package:booking/presentation/cubit/auth/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isSecurePassword = ValueNotifier<bool>(false);
    final ValueNotifier<bool> isSecureConfigurePassword = ValueNotifier<bool>(
      false,
    );
    final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        spacing: 20,
        children: [
          // User Name Input
          InputFieldForm(
            name: "user name",
            hintText: "Motaz Aboassi",
            labelTeaxt: "user name",
            validatorsProps: [FormBuilderValidators.username()],
          ),
          // Email Input
          InputFieldForm(
            name: "email",
            hintText: "example@example.example",
            labelTeaxt: "Email",
            validatorsProps: [FormBuilderValidators.email()],
          ),
          // Password Input
          ValueListenableBuilder(
            valueListenable: isSecurePassword,
            builder: (context, value, child) {
              return InputFieldForm(
                name: "password",
                hintText: "********",
                labelTeaxt: "Password",
                validatorsProps: [FormBuilderValidators.password()],
                suffixIcon: IconButton(
                  onPressed: () {
                    isSecurePassword.value = !isSecurePassword.value;
                  },
                  icon: Icon(
                    isSecurePassword.value
                        ? Icons.remove_red_eye
                        : Icons.visibility_off,
                  ),
                ),
                obscureText: !isSecurePassword.value,
              );
            },
          ),
          // Configure Password Input
          ValueListenableBuilder(
            valueListenable: isSecureConfigurePassword,
            builder: (context, value, child) {
              return InputFieldForm(
                name: "configure password",
                hintText: "********",
                labelTeaxt: "Configure Password",
                validatorsProps: [
                  (value) {
                    if (value !=
                        formKey.currentState!.fields["password"]?.value) {
                      return "Password does not match";
                    }
                    return null;
                  },
                ],
                suffixIcon: IconButton(
                  onPressed: () {
                    isSecureConfigurePassword.value =
                        !isSecureConfigurePassword.value;
                  },
                  icon: Icon(
                    isSecureConfigurePassword.value
                        ? Icons.remove_red_eye
                        : Icons.remove,
                  ),
                ),
                obscureText: !isSecureConfigurePassword.value,
              );
            },
          ),
          // Button Sign in
          BlocProvider(
            create: (_) => RegisterCubit(),
            child: ButtonSignUp(formKey: formKey),
          ),
        ],
      ),
    );
  }
}
