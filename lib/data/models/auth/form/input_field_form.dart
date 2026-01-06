import 'package:booking/data/models/auth/form/decoration_input_field.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class InputFieldForm extends StatelessWidget {
  final String name, hintText, labelTeaxt;
  final String? initialValue;
  final Widget? suffixIcon;
  final bool? obscureText;
  final List<String? Function(String?)>? validatorsProps;
  final TextInputType? textInputType;
  const InputFieldForm({
    super.key,
    required this.name,
    required this.hintText,
    required this.labelTeaxt,
    this.suffixIcon,
    this.obscureText,
    this.validatorsProps,
    this.initialValue,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    List<String? Function(String?)> validators = validatorsProps ?? [];
    validators.add(FormBuilderValidators.required());

    return FormBuilderTextField(
      initialValue: initialValue,
      name: name,
      obscureText: suffixIcon != null && obscureText == true,
      obscuringCharacter: "*",
      style: TextStyle(color: context.appTheme.primary), // text color
      cursorColor: context.appTheme.primary, // cursor color
      keyboardType: textInputType ?? TextInputType.emailAddress,
      decoration: decorationInputFieldLogin(
        hintText: hintText,
        labelTeaxt: labelTeaxt,
        suffixIcon: suffixIcon, context: context,
      ),
      validator: FormBuilderValidators.compose(validators),
    );
  }
}
