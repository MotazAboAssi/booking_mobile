import 'package:booking/data/models/tenant_view/appartement_card.dart';
import 'package:flutter/material.dart';

class FavoriteApartments extends StatelessWidget {
  const FavoriteApartments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: AppartementCard(),
              ),
            );
          },
        ),
      ),
    );
  }
}
