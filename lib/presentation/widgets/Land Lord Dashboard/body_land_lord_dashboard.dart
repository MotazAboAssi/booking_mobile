import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/landlord/display_booking_apartment/display_booking_apartment_cubit.dart';
import 'package:booking/presentation/cubit/landlord/display_booking_apartment/display_booking_apartment_states.dart';
import 'package:booking/presentation/cubit/landlord/fetch_all_apartment_for_landlord/fetch_all_apartment_for_landlord_cubit.dart';
import 'package:booking/presentation/cubit/landlord/fetch_all_apartment_for_landlord/fetch_all_apartment_for_landlord_states.dart';
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
              child: Text('close', style: TextStyle(color: Colors.blue)),
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
        'Appartment count',
        '12',
        Icons.apartment,
        bloc: FetchAllApartmentForLandlordCubit(),
        loadingState: FetchAllApartmentForLandlordLoading(
          apartments: [],
          message: null,
        ),
      ),

      _Card(
        'Rented',
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
        'Not Rented',
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
            ApartmentCard(card: cards[0]),
            BlocBuilder<
              FetchAllApartmentForLandlordCubit,
              FetchAllApartmentForLandlordStates
            >(
              builder:
                  (
                    BuildContext context,
                    FetchAllApartmentForLandlordStates state,
                  ) {
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
                              Icon(cards[1].icon, color: Colors.blue, size: 28),
                              const Spacer(),
                              Text(
                                cards[1].title,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              context.select<Null, Widget>((_) {
                                if (state
                                    is FetchAllApartmentForLandlordSuccessful) {
                                  return Text(
                                    '${state.apartments.length}',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  );
                                } else if (state
                                    is FetchAllApartmentForLandlordFaild) {
                                  return Text(
                                    '-1',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  );
                                } else {
                                  return Skeletonizer(
                                    child: Text(
                                      '0',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
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
            ),
          ],
        ),
        SizedBox(height: 24),
        const Text(
          'New Requests',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    return ListView.builder(
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(rem(1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: rem(1),
                                  children: [
                                    CircleAvatar(backgroundColor: fourthly),
                                    Column(
                                      children: [
                                        Text(requests[index].name),
                                        Text(requests[index].apartment),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Skeletonizer(
                    child: ListView.builder(
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(rem(1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(requests[index].name),
                                    Text(requests[index].apartment),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
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
                      Icon(card.icon, color: Colors.blue, size: 28),
                      const Spacer(),
                      Text(
                        card.title,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      context.select<Null, Widget>((_) {
                        if (state is FetchAllApartmentForLandlordSuccessful) {
                          return Text(
                            '${state.apartments.length}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          );
                        } else if (state is FetchAllApartmentForLandlordFaild) {
                          return Text(
                            '-1',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          );
                        } else {
                          return Skeletonizer(
                            child: Text(
                              '0',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
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
