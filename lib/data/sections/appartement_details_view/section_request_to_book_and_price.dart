import 'package:booking/data/models/auth/form/custom_snak_bar.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/keys_localization/tenant_key.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/booking_apartment/booking_apartment_cubit.dart';
import 'package:booking/presentation/cubit/booking_apartment/booking_apartment_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/range_unavailable_date.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionRequestToBookAndPrice extends StatelessWidget {
  final ApartmentType apartment;

  const SectionRequestToBookAndPrice({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.appTheme.thirdly,
        boxShadow: [BoxShadow(blurRadius: 15, spreadRadius: 5)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "${apartment.priceForMonth}\$",
                style: TextStyle(
                  fontSize: rem(1.5),
                  fontWeight: FontWeight.bold,
                  color: context.appTheme.fourthly,
                ),
              ),
              Text(TenantKeys.detailBarPriceSuffix.tr()),
            ],
          ),
          RequestBookButton(apartment: apartment),
        ],
      ),
    );
  }
}

class RequestBookButton extends StatelessWidget {
  const RequestBookButton({super.key, required this.apartment});
  final ApartmentType apartment;

  @override
  Widget build(BuildContext context) {
    // List<RangeUnavailableDate> disabledRanges = [
    //   RangeUnavailableDate(
    //     startNonAvailableDate: DateTime(2026, 1, 10),
    //     endNonAvailableDate: DateTime(2026, 1, 15),
    //   ),
    //   RangeUnavailableDate(
    //     startNonAvailableDate: DateTime(2026, 2, 1),
    //     endNonAvailableDate: DateTime(2026, 2, 3),
    //   ),
    // ];
    return BlocConsumer<BookingApartmentCubit, BookingApartmentStates>(
      builder: (BuildContext context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: context.select<Null, Color?>((_) {
              if (state is BookingApartmentSuccessful) {
                return context.appTheme.success;
              } else if (state is BookingApartmentLoading) {
                return context.appTheme.secondary;
              } else {
                return null;
              }
            }),
            backgroundColor: context.appTheme.fourthly,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
          onPressed: context.select<Null, void Function()?>((_) {
            if (state is BookingApartmentInitial ||
                state is BookingApartmentFaild) {
              return () async {
                final List<RangeUnavailableDate> dates = await HttpRequest()
                    .displayUnavailableDateForParticularApartment(
                      apartment.idApartment,
                    );

                final DateTimeRange<DateTime>? picked =
                    await showDateRangePicker(
                      context: context,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      firstDate: DateTime.now().add(const Duration(days: 1)),
                      lastDate: DateTime.now()
                          .add(const Duration(days: 1))
                          .add(const Duration(days: 2000)),
                      selectableDayPredicate:
                          (day, selectedStartDay, selectedEndDay) {
                            if (day.isBefore(DateTime.now())) return false;
                            return !isDayInDisabledRange(day, dates);
                          },
                    );
                if (picked != null) {
                  final hasConflict = dates.any((range) {
                    return picked.start.isBefore(range.endNonAvailableDate) &&
                        picked.end.isAfter(range.startNonAvailableDate);
                  });

                  if (hasConflict) {
                    customSnakBar(
                      context: context,
                      color: context.appTheme.error,
                      message: "Selected dates include unavailable days",
                    );
                    return;
                  }
                  final cubit = context.read<BookingApartmentCubit>();
                  cubit.booking(
                    apartment.idApartment,
                    picked.start,
                    picked.end,
                  );
                }
              };
            }
            return null;
          }),
          child: context.select<Null, Widget?>((_) {
            if (state is BookingApartmentLoading) {
              return SizedBox(
                width: rem(1),
                height: rem(1),
                child: CircularProgressIndicator(
                  color: context.appTheme.thirdly,
                ),
              );
            } else if (state is BookingApartmentSuccessful) {
              return Icon(Icons.check, color: context.appTheme.thirdly);
            } else {
              return Text(
                TenantKeys.detailBarRequestButton.tr(),
                style: TextStyle(color: context.appTheme.thirdly),
              );
            }
          }),
        );
      },
      listener: (context, state) async {
        if ((state is BookingApartmentSuccessful)) {
          customSnakBar(
            margin: EdgeInsets.only(bottom: rem(4)),
            context: context,
            color: context.appTheme.success,
            message: state.response.toString(),
          );
          await Future.delayed(const Duration(seconds: 1));
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(mybooking, (Route<dynamic> route) => false);
        } else if (state is BookingApartmentFaild) {
          customSnakBar(
            margin: EdgeInsets.only(bottom: rem(4)),
            context: context,
            color: context.appTheme.error,
            message: state.errorMessage,
          );
        }
      },
    );
  }
}

// bool isSameDay(DateTime a, DateTime b) {
//   return a.year == b.year && a.month == b.month && a.day == b.day;
// }

bool isDayInDisabledRange(DateTime day, List<RangeUnavailableDate> ranges) {
  for (final range in ranges) {
    if (!day.isBefore(range.startNonAvailableDate) &&
        !day.isAfter(range.endNonAvailableDate)) {
      return true;
    }
  }
  return false;
}
