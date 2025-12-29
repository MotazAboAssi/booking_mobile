import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/test/image_network.dart';
import 'package:flutter/material.dart';

class ModelDisplayApartementRented extends StatelessWidget {
  const ModelDisplayApartementRented({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: thirdly,
      ),
      child: ListTile(
        visualDensity: VisualDensity(horizontal: 4, vertical: 4),
        title: Text(
          "Bright & Modern DownTown Loft",
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold,),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            "Stay: Aug 15 - Aug 20, 2023",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        trailing: AspectRatio(
          aspectRatio: 1.5,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: networkImage),
            ),
          ),
        ),
      ),
    );
  }
}
