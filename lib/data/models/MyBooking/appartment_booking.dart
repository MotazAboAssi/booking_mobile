import 'package:booking/data/sections/appartement_details_view/section_request_to_book_and_price.dart';
import 'package:booking/helper/constant/my_booking_keys.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/my_booking_view/my_booking_view_cubit.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/booking_apartment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Appartmentbooking extends StatelessWidget {
  final BookingApartmentType? apartment;
  const Appartmentbooking({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final ApartmentType house = await HttpRequest()
            .getApartmentByIDForTenant(apartment!.apartmentID);
        Navigator.pushNamed(
          context,
          appartementDetailsViewForTenant,
          arguments: {"apartment": house},
        );
      },
      child: Card(
        color: context.appTheme.thirdly,
        elevation: 0,

        margin: EdgeInsets.symmetric(horizontal: 2, vertical: rem(0.5)),
        child: LayoutBuilder(
          builder: (context, card) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: card.maxHeight * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: fetchImageFromDB(
                            apartment!.apartment.images![0].image,
                          ),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  // : Th,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: rem(0.2),

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        spacing: rem(0.35),

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${apartment?.status.name}',
                                style: TextStyle(
                                  color: context.select<Null, Color?>((_) {
                                    if (apartment?.status.name == pendingKey) {
                                      return context.appTheme.secondary;
                                    } else if (apartment?.status.name ==
                                        confirmedKey) {
                                      return Colors.green;
                                    } else {
                                      return Colors.red;
                                    }
                                  }),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "${apartment?.apartment.description}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: rem(1),
                              fontWeight: FontWeight.w900,
                            ),
                          ),

                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: context.appTheme.secondary,
                              ),
                              Text(
                                "${apartment?.apartment.city} - ${apartment?.apartment.town}",
                                style: TextStyle(
                                  fontSize: rem(1),
                                  color: context.appTheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            color: context.appTheme.secondary,
                          ),
                          Text(
                            "${apartment?.startDate.toIso8601String().split("T")[0]} / ${apartment?.endDate.toIso8601String().split("T")[0]}",
                            style: TextStyle(color: context.appTheme.secondary),
                          ),
                        ],
                      ),

                      apartment!.status.name == BookingStatus.pending.name
                          ? PendingButton(apartment: apartment)
                          : apartment!.status.name ==
                                    BookingStatus.confirmed.name &&
                                DateTime.now().isAfter(apartment!.endDate)
                          ? ConfirmedPastButton(apartment: apartment)
                          : apartment!.status.name ==
                                BookingStatus.confirmed.name
                          ? ConfirmedButton(apartment: apartment)
                          : Container(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ConfirmedPastButton extends StatelessWidget {
  const ConfirmedPastButton({super.key, required this.apartment});

  final BookingApartmentType? apartment;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: rem(0.5),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Tooltip(
            message: 'بدي نت',
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // بدون انحناءات
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ), // حجم اللزر
              ),
              onPressed: null,
              child: Text('Contact Owner'),
            ),
          ),
        ),

        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow, // لون الخلفية
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // بدون انحناءات
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ), // حجم الزر
            ),
            onPressed: () async {
              Navigator.pushNamed(
                context,
                rateYourStayView,
                arguments: {'house': apartment},
              );
            },
            child: Text(
              'Rate',
              style: TextStyle(color: context.appTheme.primary),
            ),
          ),
        ),
      ],
    );
  }
}

class ConfirmedButton extends StatelessWidget {
  const ConfirmedButton({super.key, required this.apartment});

  final BookingApartmentType? apartment;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: rem(0.5),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Tooltip(
            message: 'بدي نت',
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // بدون انحناءات
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ), // حجم اللزر
              ),
              onPressed: null,
              child: Text('Contact Owner'),
            ),
          ),
        ),

        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // لون الخلفية
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // بدون انحناءات
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ), // حجم الزر
            ),
            onPressed: () async {
              await HttpRequest().deleteBookingParticularApartmentByID(
                apartment!.bookingID,
              );
              final cubit = context.read<MyBookingViewCubit>();
              cubit.getAllApartmentsBooking();
            },
            child: Text(
              'Cancele',
              style: TextStyle(color: context.appTheme.thirdly),
            ),
          ),
        ),
      ],
    );
  }
}

class PendingButton extends StatelessWidget {
  const PendingButton({super.key, required this.apartment});

  final BookingApartmentType? apartment;

  @override
  Widget build(BuildContext context) {
    final List<DateTime> disabledDates = [
      // DateTime(2025, 1, 10),
      DateTime(2026, 1, 6),
      DateTime(2026, 1, 5),
    ];
    return Row(
      spacing: rem(0.5),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.appTheme.fourthly, // لون الخلفية
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // بدون انحناءات
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ), // حجم اللزر
            ),
            onPressed: () async {
              final DateTimeRange<DateTime>? picked = await showDateRangePicker(
                context: context,
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                firstDate: DateTime.now().add(const Duration(days: 1)),
                lastDate: DateTime.now()
                    .add(const Duration(days: 1))
                    .add(const Duration(days: 2000)),
                selectableDayPredicate:
                    (day, selectedStartDay, selectedEndDay) {
                      final isDisabled = disabledDates.any(
                        (disabledDay) => isSameDay(disabledDay, day),
                      );
                      return !isDisabled;
                    },
              );
              if (picked != null) {
                await HttpRequest().updateBookingParticularApartmentByID(
                  apartment!.bookingID,
                  picked.start,
                  picked.end,
                );
                final cubit = context.read<MyBookingViewCubit>();
                cubit.getAllApartmentsBooking();
              }
            },
            child: Text(
              'Edit',
              style: TextStyle(color: context.appTheme.thirdly),
            ),
          ),
        ),

        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // لون الخلفية
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // بدون انحناءات
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ), // حجم الزر
            ),
            onPressed: () async {
              await HttpRequest().deleteBookingParticularApartmentByID(
                apartment!.bookingID,
              );
              final cubit = context.read<MyBookingViewCubit>();
              cubit.getAllApartmentsBooking();
            },
            child: Text(
              'Cancele',
              style: TextStyle(color: context.appTheme.thirdly),
            ),
          ),
        ),
      ],
    );
  }
}
