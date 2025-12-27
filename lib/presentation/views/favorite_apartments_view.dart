import 'dart:developer';

import 'package:booking/data/models/tenant_view/appartement_card.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/navigate_to.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/favorite_apartment_view.dart/favorite_apartment_view_cubit.dart';
import 'package:booking/presentation/cubit/favorite_apartment_view.dart/favorite_apartment_view_states.dart';
import 'package:booking/presentation/widgets/button_refresh.dart';
import 'package:booking/presentation/widgets/custome_bottom_navigation_bar.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoriteApartments extends StatefulWidget {
  const FavoriteApartments({super.key});

  @override
  State<FavoriteApartments> createState() => _FavoriteApartmentsState();
}

class _FavoriteApartmentsState extends State<FavoriteApartments> {
  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<FavoriteApartmentViewCubit>(context);
    try {
      cubit.getAllFavoriteApartment();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Wishlite",
          style: TextStyle(fontSize: rem(1.5), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: ButtonRefresh(
        action: () async {
          final cubit = context.read<FavoriteApartmentViewCubit>();
          await cubit.getAllFavoriteApartment();
        },
      ),
      bottomNavigationBar: CustomeBottomNavigationBar(index: 1),
      body: SafeArea(
        child:
            BlocBuilder<
              FavoriteApartmentViewCubit,
              FavoriteApartmentViewStates
            >(
              builder: (context, state) {
                if (state is FavoriteApartmentViewFaild) {
                  return Padding(
                    padding: EdgeInsets.all(rem(1)),
                    child: Center(
                      child: Text(
                        "No Internet 😢",
                        style: TextStyle(
                          fontSize: rem(2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                } else if (state is FavoriteApartmentViewSuccessful) {
                  final List<ApartmentType> favoroites = state.favorites;
                  return favoroites.isEmpty
                      ? Center(
                          child: Text(
                            "No Favorite ❤️ Apartments yet",
                            style: TextStyle(
                              fontSize: rem(1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: favoroites.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: AppartementCard(
                                  apartment: favoroites[index],
                                ),
                              ),
                            );
                          },
                        );
                } else {
                  return Skeletonizer(
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
                  );
                }
              },
            ),
      ),
    );
  }
}
