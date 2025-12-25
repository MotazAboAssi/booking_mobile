import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';

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
      child: Builder(
        builder: (context) {
          return Row(
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                  backgroundColor: fourthly,
                ),
                onPressed: () async {
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
                              final isDisabled = disabledDates.any(
                                (disabledDay) => isSameDay(disabledDay, day),
                              );

                              return !isDisabled;
                            },
                      );
                  if (picked != null) {
                    try {
                      await HttpRequest().bookingParticularApartmentByID(
                        apartment.idApartment,
                        picked.start,
                        picked.end,
                      );
                    } catch (e) {
                      printRed(e.toString());
                    }
                  }
                },

                child: Text(
                  "Request to Book",
                  style: TextStyle(color: thirdly),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

final List<DateTime> disabledDates = [
  // DateTime(2025, 1, 10),
  DateTime(2025, 12, 25),
  DateTime(2026, 1, 5),
];

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
