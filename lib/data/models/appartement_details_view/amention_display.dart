import 'package:booking/data/models/appartement_details_view/amention_card.dart';
import 'package:booking/data/models/appartement_details_view/amention_display_dialog.dart';
import 'package:booking/helper/constant/amentions.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:flutter/material.dart';

List<Widget> amentionDisplay(BuildContext context, List<int> amention) {
  List<Widget> arr = [];

  if (amention.length > 3) {
    amention.sublist(0, 3).forEach((i) {
      arr.add(
        AmentionCard(
          icon: amentions[i - 1].icon,
          title: amentions[i - 1].title,
          fontSize: 1,
          iconsSize: 2,
        ),
      );
    });
    arr.add(
      InkWell(
        onTap: () async {
          await showDialog(
            context: context,
            builder: (context) => amentionDisplayDialog(amention),
          );
        },
        child: CircleAvatar(
          foregroundColor: context.appTheme.primarye,
          child: Text("+${amention.length - 3}"),
        ),
      ),
    );
  } else {
    for (var i in amention) {
      arr.add(
        AmentionCard(
          icon: amentions[i - 1].icon,
          title: amentions[i - 1].title,
          fontSize: 1,
          iconsSize: 2,
        ),
      );
    }
  }
  return arr;
}
