import 'package:booking/data/models/auth/form/decoration_input_field.dart';
import 'package:booking/data/models/auth/form/input_field_form.dart';
import 'package:booking/helper/constant/form_keys/registers_keys.dart';
import 'package:booking/helper/methods/comapre_two_date.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/methods/to_capitalize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';


class SectionGroupOfInputField extends StatelessWidget {
  const SectionGroupOfInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isSecure = ValueNotifier<bool>(false);
    return Column(
      spacing: rem(1),
      children: [
        InputFieldForm(
          name: phoneKey,
          hintText: "+963*********",
          labelTeaxt: "Phone No",
          textInputType: TextInputType.phone,
          validatorsProps: [
            FormBuilderValidators.phoneNumber(
              regex: RegExp(r"^\+963[0-9]{9}$"),
            ),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: isSecure,
          builder: (context, value, child) {
            return InputFieldForm(
              name: passwordKey,
              hintText: "********",
              labelTeaxt: toCapitalize(passwordKey),
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
          hintText: "Motaz",
          labelTeaxt: toCapitalize(firstNameKey),
          validatorsProps: [FormBuilderValidators.firstName()],
        ),
        InputFieldForm(
          name: lastNameKey,
          hintText: "Abo Assi",
          labelTeaxt: toCapitalize(lastNameKey),
          validatorsProps: [FormBuilderValidators.lastName()],
        ),
        FormBuilderDateTimePicker(
          inputType: InputType.date,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          format: DateFormat('dd-MM-yyyy'),
          decoration: decorationInputFieldLogin(
            hintText: "select your date of birth",
            labelTeaxt: dateOfBirthKey,
          ),

          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            (value) {
              if (value != null && compareTwoDate(value, DateTime.now()) >= 0) {
                return "The birthday field must be a date before today.";
              }
              return null;
            },
          ]),
          name: dateOfBirthKey,
          firstDate: DateTime(1990, 1, 1),
          lastDate: DateTime(5000),
        ),
      ],
    );
  }
}
