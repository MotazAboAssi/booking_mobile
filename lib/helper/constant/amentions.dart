import 'package:booking/data/models/appartement_details_view/amention_model.dart';
import 'package:flutter/material.dart';
import 'package:booking/helper/keys_localization/landlord_key.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

const List<AmentionModel> amentions = [
  AmentionModel(id: 1, icon: Icons.tv, titleKey: 'amenities.tv'),
  AmentionModel(id: 2, icon: Icons.wifi, titleKey: 'amenities.wifi'),
  AmentionModel(id: 3, icon: Icons.ac_unit, titleKey: 'amenities.air_con'),
  AmentionModel(id: 4, icon: Icons.elevator, titleKey: 'amenities.lift'),
  AmentionModel(
    id: 5,
    icon: Icons.local_fire_department,
    titleKey: 'amenities.heating',
  ),
  AmentionModel(
    id: 6,
    icon: Icons.local_laundry_service,
    titleKey: 'amenities.washing_machine',
  ),
  AmentionModel(id: 7, icon: Icons.dry, titleKey: 'amenities.dryer'),
  AmentionModel(id: 8, icon: Icons.security, titleKey: 'amenities.doorman'),
  AmentionModel(id: 9, icon: Icons.chair_alt, titleKey: 'amenities.furnished'),
  AmentionModel(id: 10, icon: Icons.pool, titleKey: 'amenities.pool'),
  AmentionModel(
    id: 11,
    icon: Icons.bathtub,
    titleKey: 'amenities.private_bathroom',
  ),
  AmentionModel(
    id: 12,
    icon: Icons.wb_sunny,
    titleKey: 'amenities.natural_light',
  ),
  AmentionModel(id: 13, icon: Icons.park, titleKey: 'amenities.garden'),
  AmentionModel(id: 14, icon: Icons.balcony, titleKey: 'amenities.balcony'),
  AmentionModel(
    id: 15,
    icon: Icons.accessible,
    titleKey: 'amenities.wheelchair',
  ),
];
