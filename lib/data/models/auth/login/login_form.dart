import 'package:booking/data/models/auth/form/input_field_form.dart';
import 'package:booking/data/models/auth/login/button_sign_in.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/auth/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late GlobalKey<FormBuilderState> formKey;

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
    final ValueNotifier<bool> isSecure = ValueNotifier<bool>(false);
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
            textInputType: TextInputType.phone,
            validatorsProps: [
              FormBuilderValidators.phoneNumber(
                regex: RegExp(r"^\+963[0-9]{9}$"),
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
                suffixIcon: IconButton(
                  onPressed: () {
                    isSecure.value = !isSecure.value;
                  },
                  icon: Icon(
                    isSecure.value
                        ? Icons.visibility_off
                        : Icons.remove_red_eye,
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
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have ana ccount?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: rem(1)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, roleSelectionView);
                },
                child: Text(
                  "Sign Up",
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
  }
}
