import 'package:booking/helper/constant/my_booking_keys.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/my_booking_view/my_booking_view_cubit.dart';
import 'package:booking/presentation/cubit/my_booking_view/my_booking_view_states.dart';
import 'package:booking/presentation/widgets/button_refresh.dart';
import 'package:booking/presentation/widgets/custome_bottom_navigation_bar_for_tenant.dart';
import 'package:flutter/material.dart';
import 'package:booking/presentation/widgets/my_Booking/body_my_booking.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyBookingView extends StatefulWidget {
  const MyBookingView({super.key});

  @override
  State<MyBookingView> createState() => _LandLordDashboardState();
}

class _LandLordDashboardState extends State<MyBookingView> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<MyBookingViewCubit>();
    cubit.getAllApartmentsBooking();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: ButtonRefresh(
            action: () async {
              final cubit = context.read<MyBookingViewCubit>();
              cubit.getAllApartmentsBooking();
            },
          ),
          appBar: AppBar(
            title: Text(
              "My Booking",
              style: TextStyle(fontSize: rem(1.5), fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            bottom: const TabBar(
              labelStyle: TextStyle(fontSize: 16),
              labelColor: Color.fromARGB(255, 0, 0, 0),
              unselectedLabelColor: Color.fromARGB(179, 124, 124, 124),
              indicatorColor: Color.fromARGB(255, 12, 75, 194),
              tabs: [
                Tab(text: 'Current'),
                Tab(text: 'Past'),
                Tab(text: 'Canceled'),
              ],
            ),
          ),
          bottomNavigationBar: CustomeBottomNavigationBarForTenant(index: 2),
          body: Padding(
            padding: EdgeInsets.only(top: rem(1)),
            child: BlocBuilder<MyBookingViewCubit, MyBookingViewStates>(
              builder: (context, state) {
                final booking = state.bookings;

                if (state is MyBookingViewSuccessful) {
                  return TabBarView(
                    children: [
                      BodyMyBooking(
                        apartments: booking
                            .where(
                              (apartment) =>
                                  apartment.status.name == pendingKey ||
                                  (apartment.status.name == confirmedKey &&
                                      DateTime.now().isBefore(
                                        apartment.endDate,
                                      )),
                            )
                            .toList(),
                      ),
                      BodyMyBooking(
                        apartments: booking
                            .where(
                              (apartment) =>
                                  apartment.status.name == confirmedKey &&
                                  DateTime.now().isAfter(apartment.endDate),
                            )
                            .toList(),
                      ),
                      BodyMyBooking(
                        apartments: booking
                            .where(
                              (apartment) =>
                                  apartment.status.name == canceledKey,
                            )
                            .toList(),
                      ),
                    ],
                  );
                }
                return Skeletonizer(
                  child: TabBarView(
                    children: [
                      BodyMyBooking(apartments: booking),
                      BodyMyBooking(apartments: booking),
                      BodyMyBooking(apartments: booking),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
