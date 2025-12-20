import 'dart:developer';

import 'package:booking/data/models/tenant_view/appartement_card.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/tenant_view/tenant_view_cubit.dart';
import 'package:booking/presentation/cubit/tenant_view/tenant_view_state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SectionMostPopular extends StatefulWidget {
  const SectionMostPopular({super.key});

  @override
  State<SectionMostPopular> createState() => _SectionMostPopularState();
}

class _SectionMostPopularState extends State<SectionMostPopular> {
  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<TenantViewCubit>(context);
    try {
      cubit.getAllApartmentForTenant();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Builder(
        builder: (context) {
          return Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Text(
                  "Most Popular",
                  style: TextStyle(
                    fontSize: rem(2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 7 / 6,
                child: BlocBuilder<TenantViewCubit, TenantViewStateCubit>(
                  builder: (context, state) {
                    if (state is TenantViewLoading) {
                      return Skeletonizer(
                        child: SizedBox(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return AspectRatio(
                                aspectRatio: 1,
                                child: AppartementCard(
                                  isFavorite: false,
                                  apartment: null,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else if (state is TenantViewSucceeful) {
                      final apartments = state.apartment;
                      return apartments.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: apartments.length,
                              itemBuilder: (context, index) {
                                return AspectRatio(
                                  aspectRatio: 1,
                                  child: AppartementCard(
                                    isFavorite: false,
                                    apartment: state.apartment[index],
                                  ),
                                );
                              },
                            )
                          : Container(
                              margin: EdgeInsets.all(rem(0.5)),
                              decoration: BoxDecoration(
                                color: secondary,
                                borderRadius: BorderRadius.circular(rem(1.4)),
                              ),
                              child: Center(
                                child: Text(
                                  "⚠️ Not Found Apartment",
                                  style: TextStyle(
                                    fontSize: rem(1.5),
                                    fontWeight: FontWeight.bold,
                                    color: thirdly,
                                  ),
                                ),
                              ),
                            );
                    } else if (state is TenantViewFaild) {
                      return Container(
                        margin: EdgeInsets.all(rem(0.5)),
                        decoration: BoxDecoration(
                          color: secondary,
                          borderRadius: BorderRadius.circular(rem(1.4)),
                        ),
                        child: Center(
                          child: Text(
                            state.error,
                            style: TextStyle(
                              fontSize: rem(1.5),
                              fontWeight: FontWeight.bold,
                              color: thirdly,
                            ),
                          ),
                        ),
                      );
                    }
                    return Text("data");
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
