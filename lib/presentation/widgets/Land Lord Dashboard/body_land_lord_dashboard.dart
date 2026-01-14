import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/keys_localization/landlord_key.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/landlord/display_booking_apartment/display_booking_apartment_cubit.dart';
import 'package:booking/presentation/cubit/landlord/display_booking_apartment/display_booking_apartment_states.dart';
import 'package:booking/presentation/cubit/landlord/fetch_all_apartment_for_landlord/fetch_all_apartment_for_landlord_cubit.dart';
import 'package:booking/presentation/cubit/landlord/fetch_all_apartment_for_landlord/fetch_all_apartment_for_landlord_states.dart';
import 'package:booking/types/booking_apartment_type.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LandlordDashboard extends StatefulWidget {
  const LandlordDashboard({super.key});

  @override
  State<LandlordDashboard> createState() => _LandlordDashboardState();
}

class _LandlordDashboardState extends State<LandlordDashboard> {
  @override
  void initState() {
    super.initState();
    final displayBookingApartment =
        BlocProvider.of<DisplayBookingApartmentCubit>(context);
    displayBookingApartment.displayBookingApartment();
    final fetchAllApartmentForLandlord =
        BlocProvider.of<FetchAllApartmentForLandlordCubit>(context);
    fetchAllApartmentForLandlord.fetchAllApartmentForLandlord();
  }

  final requests = [
    _Request('أحمد علي', 'شقة رقم 3'),
    _Request('محمد حسن', 'شقة رقم 5'),
    _Request('محمد حسن', 'شقة رقم 5'),
    _Request('محمد حسن', 'شقة رقم 5'),
    _Request('محمد حسن', 'شقة رقم 5'),
    _Request('محمد حسن', 'شقة رقم 5'),
    _Request('محمد حسن', 'شقة رقم 5'),
    _Request('محمد حسن', 'شقة رقم 5'),
    _Request('محمد حسن', 'شقة رقم 5'),
  ];

  final rentedApartments = [
    'شقة رقم 1',
    'شقة رقم 3',
    'شقة رقم 7',
    'شقة رقم 1',
    'شقة رقم 3',
    'شقة رقم 7',
    'شقة رقم 1',
    'شقة رقم 3',
    'شقة رقم 7',
  ];

  final notRentedApartments = ['شقة رقم 2', 'شقة رقم 4', 'شقة رقم 6'];

  void _showApartmentsDialog(
    BuildContext context, {
    required String title,
    required List<String> apartments,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            height: 300,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: apartments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.home),
                  title: Text(apartments[index]),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'close',
                style: TextStyle(color: context.appTheme.fourthly),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = [
      _Card(
        LandlordKeys.dashboardStatsCount.tr(),
        '12',
        Icons.apartment,
        bloc: FetchAllApartmentForLandlordCubit(),
        loadingState: FetchAllApartmentForLandlordLoading(
          apartments: [],
          message: null,
        ),
      ),

      _Card(
        LandlordKeys.dashboardStatsRented.tr(),
        '8',
        Icons.check_circle,
        onTap: () async {
          _showApartmentsDialog(
            context,
            title: 'Rented Apartments',
            apartments: rentedApartments,
          );
        },
      ),

      _Card(
        LandlordKeys.dashboardStatsNotRented.tr(),
        '4',
        Icons.cancel,
        onTap: () {
          _showApartmentsDialog(
            context,
            title: 'Available Apartments',
            apartments: notRentedApartments,
          );
        },
      ),

      _Card('Balance', '\$1200', Icons.account_balance_wallet),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // itemCount: cards.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.3,
          ),
          children: [
            RentCard(cards: cards),
            NotRentCard(cards: cards),
            ApartmentCard(card: cards[0]),
          ],
        ),
        SizedBox(height: 24),
        Text(
          LandlordKeys.dashboardRequestsTitle.tr(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Expanded(
          child:
              BlocBuilder<
                DisplayBookingApartmentCubit,
                DisplayBookingApartmentStates
              >(
                builder: (context, state) {
                  if (state is DisplayBookingApartmentSuccessful) {
                    List<BookingApartmentType> bookings = state.bookings
                        .where(
                          (element) =>
                              !(element.status == BookingStatus.canceled ||
                                  (element.status == BookingStatus.confirmed &&
                                      element.endDate.isBefore(
                                        DateTime.now(),
                                      ))),
                        )
                        .toList();
                    return bookings.isEmpty
                        ? Center(
                            child: Text(
                              LandlordKeys.noApartments.tr(),
                              style: TextStyle(
                                fontSize: rem(1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: bookings.length,
                            itemBuilder: (context, index) {
                              BookingApartmentType book = bookings[index];
                              return RequestModel(book: book);
                            },
                          );
                  }
                  return Skeletonizer(
                    child: ListView.builder(
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        return RequestModel(book: null);
                      },
                    ),
                  );
                },
              ),
        ),
      ],
    );
  }
}

class NotRentCard extends StatelessWidget {
  const NotRentCard({super.key, required this.cards});

  final List<_Card> cards;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      FetchAllApartmentForLandlordCubit,
      FetchAllApartmentForLandlordStates
    >(
      builder: (BuildContext context, FetchAllApartmentForLandlordStates cubit1) {
        return BlocBuilder<
          DisplayBookingApartmentCubit,
          DisplayBookingApartmentStates
        >(
          builder: (context, cubit2) {
            final isSuccessful = cubit2 is DisplayBookingApartmentSuccessful;
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      cards[2].icon,
                      color: context.appTheme.fourthly,
                      size: 28,
                    ),
                    const Spacer(),
                    Text(
                      cards[2].title,
                      style: TextStyle(color: context.appTheme.secondary),
                    ),
                    const SizedBox(height: 4),
                    context.select<Null, Widget>((_) {
                      if (cubit1 is FetchAllApartmentForLandlordSuccessful) {
                        return Text(
                          isSuccessful
                              ? '${cubit1.apartments.length - cubit2.bookings.where((e) => e.status == BookingStatus.confirmed && e.startDate.isBefore(DateTime.now()) && e.endDate.isAfter(DateTime.now())).toList().length}'
                              : 'no internet',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: context.appTheme.fourthly,
                          ),
                        );
                      } else if (cubit1 is FetchAllApartmentForLandlordFaild) {
                        return Text(
                          '-1',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: context.appTheme.fourthly,
                          ),
                        );
                      } else {
                        return Skeletonizer(
                          child: Text(
                            '0',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: context.appTheme.fourthly,
                            ),
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class RentCard extends StatelessWidget {
  const RentCard({super.key, required this.cards});

  final List<_Card> cards;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      FetchAllApartmentForLandlordCubit,
      FetchAllApartmentForLandlordStates
    >(
      builder: (BuildContext context, FetchAllApartmentForLandlordStates cubit1) {
        return BlocBuilder<
          DisplayBookingApartmentCubit,
          DisplayBookingApartmentStates
        >(
          builder: (context, cubit2) {
            final isSuccessful = cubit2 is DisplayBookingApartmentSuccessful;
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      cards[1].icon,
                      color: context.appTheme.fourthly,
                      size: 28,
                    ),
                    const Spacer(),
                    Text(
                      cards[1].title,
                      style: TextStyle(color: context.appTheme.secondary),
                    ),
                    const SizedBox(height: 4),
                    context.select<Null, Widget>((_) {
                      if (cubit1 is FetchAllApartmentForLandlordSuccessful) {
                        return Text(
                          isSuccessful
                              ? '${cubit2.bookings.where((e) => e.status == BookingStatus.confirmed && e.startDate.isBefore(DateTime.now()) && e.endDate.isAfter(DateTime.now())).toList().length}'
                              : 'no internet',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: context.appTheme.fourthly,
                          ),
                        );
                      } else if (cubit1 is FetchAllApartmentForLandlordFaild) {
                        return Text(
                          '-1',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: context.appTheme.fourthly,
                          ),
                        );
                      } else {
                        return Skeletonizer(
                          child: Text(
                            '0',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: context.appTheme.fourthly,
                            ),
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class RequestModel extends StatelessWidget {
  const RequestModel({super.key, required this.book});

  final BookingApartmentType? book;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          detailRequestView,
          arguments: {'book': book},
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(rem(1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${book?.startDate.toIso8601String().split('T')[0]} - ${book?.endDate.toIso8601String().split('T')[0]}',
                    style: TextStyle(
                      fontSize: rem(1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'total cost : ${book?.totalCost} \$.',
                    style: TextStyle(
                      fontSize: rem(1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'id apartment : ${book?.apartmentID}',
                    style: TextStyle(
                      fontSize: rem(1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'status : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${book?.status.name}',
                    style: TextStyle(
                      color: book?.status == null
                          ? null
                          : book!.status == BookingStatus.pending
                          ? context.appTheme.fourthly
                          : context.appTheme.success,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ApartmentCard extends StatelessWidget {
  const ApartmentCard({super.key, required this.card});

  final _Card card;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      FetchAllApartmentForLandlordCubit,
      FetchAllApartmentForLandlordStates
    >(
      builder:
          (BuildContext context, FetchAllApartmentForLandlordStates state) {
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  dispalyResaultCategory,
                  arguments: {'apartments': state.apartments},
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        card.icon,
                        color: context.appTheme.fourthly,
                        size: 28,
                      ),
                      const Spacer(),
                      Text(
                        card.title,
                        style: TextStyle(color: context.appTheme.secondary),
                      ),
                      const SizedBox(height: 4),
                      context.select<Null, Widget>((_) {
                        if (state is FetchAllApartmentForLandlordSuccessful) {
                          return Text(
                            '${state.apartments.length}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: context.appTheme.fourthly,
                            ),
                          );
                        } else if (state is FetchAllApartmentForLandlordFaild) {
                          return Text(
                            '-1',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: context.appTheme.fourthly,
                            ),
                          );
                        } else {
                          return Skeletonizer(
                            child: Text(
                              '0',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: context.appTheme.fourthly,
                              ),
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
    );
  }
}

class _Card {
  final String title;
  final String value;
  final IconData icon;
  final StateStreamable<Object?>? bloc;
  final Object? loadingState;
  final VoidCallback? onTap;

  _Card(
    this.title,
    this.value,
    this.icon, {
    this.onTap,
    this.bloc,
    this.loadingState,
  });
}

class _Request {
  final String name;
  final String apartment;

  _Request(this.name, this.apartment);
}
