import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/rate_your_stay/rate_your_stay_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionShareDetails extends StatefulWidget {
  const SectionShareDetails({super.key});

  @override
  State<SectionShareDetails> createState() => _SectionShareDetailsState();
}

class _SectionShareDetailsState extends State<SectionShareDetails> {
  TextEditingController comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Share More Details",

          style: TextStyle(fontWeight: FontWeight.bold, fontSize: rem(1.5)),
        ),
        Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),

          child: TextField(
            maxLines: 5,
            maxLength: 79,
            controller: comment,
            buildCounter:
                (
                  context, {
                  required currentLength,
                  required isFocused,
                  required maxLength,
                }) {
                  if (isFocused || currentLength != 0) {
                    final pov = BlocProvider.of<RateYourStayCubit>(
                      context,
                    ).state.pov;
                    pov.comment = comment.text;
                    if (currentLength == maxLength) {
                      return Text(
                        "$currentLength = $maxLength",
                        style: TextStyle(color: context.appTheme.error),
                      );
                    } else {
                      return Text("$currentLength < $maxLength");
                    }
                  }
                  return null;
                },
            decoration: InputDecoration(
              hintText:
                  "How was the chek-in process? Was the apartement as described? what did you love or think could be imporved?",
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
      ],
    );
  }
}
