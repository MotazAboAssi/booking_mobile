import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/services/auth_storage.dart';
import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  final String city;
  const CityCard({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await AuthStorage().deleteAllData();
      },
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(2),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),

                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/freedom.jpg"),
                  ), // TODO add to pubspec.ymal
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primary.withAlpha(127),
                ),
              ),
              Center(
                child: Text(
                  city,
                  style: TextStyle(
                    color: thirdly,
                    fontSize: rem(1.1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
