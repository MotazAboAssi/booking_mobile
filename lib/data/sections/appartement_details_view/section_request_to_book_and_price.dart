import 'package:booking/data/models/auth/form/custom_snak_bar.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/booking_apartment/booking_apartment_cubit.dart';
import 'package:booking/presentation/cubit/booking_apartment/booking_apartment_states.dart';
import 'package:booking/types/apartment_type.dart';
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
        color: thirdly,
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
                  color: fourthly,
                ),
              ),
              Text(" /month"),
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
    final List<DateTime> disabledDates = [
      // DateTime(2025, 1, 10),
      DateTime(2026, 1, 6),
      DateTime(2026, 1, 5),
    ];
    return BlocConsumer<BookingApartmentCubit, BookingApartmentStates>(
      builder: (BuildContext context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: context.select<Null, Color?>((_) {
              if (state is BookingApartmentSuccessful) {
                return Colors.green;
              } else if (state is BookingApartmentLoading) {
                return Colors.grey;
              } else {
                return null;
              }
            }),
            backgroundColor: fourthly,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
          onPressed: context.select<Null, void Function()?>((_) {
            if (state is BookingApartmentInitial ||
                state is BookingApartmentFaild) {
              return () async {
                final DateTimeRange<DateTime>? picked =
                    await showDateRangePicker(
                      errorFormatText: "Invalid format",
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
                  final cubit = context.read<BookingApartmentCubit>();
                  cubit.booking(
                    apartment.idApartment,
                    picked.start,
                    picked.end,
                  );
                }
              };
            }
            return () {
              printRed("object");
            };
          }),
          child: context.select<Null, Widget?>((_) {
            if (state is BookingApartmentLoading) {
              return SizedBox(
                width: rem(1),
                height: rem(1),
                child: CircularProgressIndicator(color: thirdly),
              );
            } else if (state is BookingApartmentSuccessful) {
              return Icon(Icons.check, color: thirdly);
            } else {
              return Text("Request to Book", style: TextStyle(color: thirdly));
            }
          }),
        );
      },
      listener: (context, state) async {
        if ((state is BookingApartmentSuccessful)) {
          customSnakBar(
            margin: EdgeInsets.only(bottom: rem(4)),
            context: context,
            color: Colors.green,
            message: state.response.toString(),
          );
          await Future.delayed(const Duration(seconds: 1));
          Navigator.pop(context);
        } else if (state is BookingApartmentFaild) {
          customSnakBar(
            margin: EdgeInsets.only(bottom: rem(4)),
            context: context,
            color: Colors.red,
            message: state.errorMessage,
          );
        }
      },
    );
  }
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
