import 'package:booking/data/models/auth/form/input_field_form.dart';
import 'package:booking/data/models/auth/register/button_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isDisplayPassword = ValueNotifier<bool>(false);
    final ValueNotifier<bool> isDisplayConfigurePassword = ValueNotifier<bool>(
      false,
    );
    final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        spacing: 20,
        children: [
          // Title Inputs
          Text(
            "Sign up",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.08,
              color: Colors.white,
            ),
          ),
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
            valueListenable: isDisplayPassword,
            builder: (context, value, child) {
              return InputFieldForm(
                name: "password",
                hintText: "********",
                labelTeaxt: "Password",
                validatorsProps: [FormBuilderValidators.password()],
                suffixIcon: IconButton(
                  onPressed: () {
                    isDisplayPassword.value = !isDisplayPassword.value;
                  },
                  icon: Icon(
                    isDisplayPassword.value
                        ? Icons.remove_red_eye
                        : Icons.remove,
                  ),
                ),
                obscureText: !isDisplayPassword.value,
              );
            },
          ),
          // Configure Password Input
          ValueListenableBuilder(
            valueListenable: isDisplayConfigurePassword,
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
                    isDisplayConfigurePassword.value =
                        !isDisplayConfigurePassword.value;
                  },
                  icon: Icon(
                    isDisplayConfigurePassword.value
                        ? Icons.remove_red_eye
                        : Icons.remove,
                  ),
                ),
                obscureText: !isDisplayConfigurePassword.value,
              );
            },
          ),
          // Button Sign in
          ButtonSignUp(formKey: formKey),
        ],
      ),
    );
  }
}
