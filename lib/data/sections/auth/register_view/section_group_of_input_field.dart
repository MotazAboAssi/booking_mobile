import 'package:booking/data/models/auth/form/decoration_input_field.dart';
import 'package:booking/data/models/auth/form/input_field_form.dart';
import 'package:booking/helper/constant/form_keys/registers_keys.dart';
import 'package:booking/helper/keys_localization/auth_key.dart';
import 'package:booking/helper/methods/comapre_two_date.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:intl/intl.dart';

class SectionGroupOfInputField extends StatefulWidget {
  const SectionGroupOfInputField({super.key});

  @override
  State<SectionGroupOfInputField> createState() =>
      _SectionGroupOfInputFieldState();
}

class _SectionGroupOfInputFieldState extends State<SectionGroupOfInputField> {
  final ValueNotifier<bool> isSecure = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: rem(1),
      children: [
        InputFieldForm(
          name: phoneKey,
          hintText: AuthKeys.phoneHint.tr(),
          labelTeaxt: AuthKeys.loginInputPhoneLabel.tr(),
          textInputType: TextInputType.phone,
          validatorsProps: [
            FormBuilderValidators.phoneNumber(
              regex: RegExp(r"^\+9639[0-9]{8}$"),
              errorText: AuthKeys.loginErrorInputPhone.tr(),
            ),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: isSecure,
          builder: (context, value, child) {
            return InputFieldForm(
              name: passwordKey,
              hintText: "********",
              labelTeaxt: AuthKeys.passwordLabel.tr(),
              suffixIcon: IconButton(
                onPressed: () {
                  isSecure.value = !isSecure.value;
                },
                icon: Icon(
                  isSecure.value ? Icons.visibility_off : Icons.remove_red_eye,
                ),
              ),
              obscureText: !isSecure.value,
              validatorsProps: [FormBuilderValidators.password()],
            );
          },
        ),
        InputFieldForm(
          name: firstNameKey,
          hintText: AuthKeys.firstNameHint.tr(),
          labelTeaxt: AuthKeys.firstNameLabel.tr(),
        ),
        InputFieldForm(
          name: lastNameKey,
          hintText: AuthKeys.lastNameHint.tr(),
          labelTeaxt: AuthKeys.lastNameLabel.tr(),
        ),
        FormBuilderDateTimePicker(
          name: dateOfBirthKey,
          keyboardType: TextInputType.none,
          focusNode: FocusNode(canRequestFocus: false),
          inputType: InputType.date,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          format: DateFormat('dd-MM-yyyy'),
          decoration: decorationInputFieldLogin(
            hintText: AuthKeys.dobHint.tr(),
            labelTeaxt: AuthKeys.dobLabel.tr(),
            context: context,
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: AuthKeys.loginErrorInputPassword.tr(),
            ),
            (value) {
              if (value != null && compareTwoDate(value, DateTime.now()) >= 0) {
                return;
              }
              return null;
            },
          ]),
          firstDate: DateTime(1990, 1, 1),
          lastDate: DateTime.now(), // also fix this 😉
        ),
      ],
    );
  }
}
