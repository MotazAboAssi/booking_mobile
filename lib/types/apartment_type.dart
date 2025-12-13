import 'dart:io';
import 'package:booking/helper/methods/convert_string_to_list_of_integer.dart';

class ApartmentType {
  final int idApartment;
  final int idLandlord;
  final double rating;
  final String city;
  final String town;
  final double space;
  final int rooms;
  final String? location;
  final double priceForMonth;
  final String description;
  final List<int> features;
  final List<File> images;

  ApartmentType({
    required this.city,
    required this.town,
    required this.space,
    required this.rooms,
    this.location,
    required this.priceForMonth,
    required this.description,
    required this.features,
    required this.images,
    required this.idApartment,
    required this.idLandlord,
    required this.rating,
  });

  factory ApartmentType.fromJson(Map<String, dynamic> json) {
    final apartment = json['apartment'];
    return ApartmentType(
      idApartment: apartment["id"],
      idLandlord: apartment["user_id"],
      city: apartment['city'],
      town: apartment['town'],
      space: apartment['space'],
      rooms: apartment['rooms'],
      location: apartment['location'],
      priceForMonth: apartment['price_for_month'],
      description: apartment['description'],
      features: convertStringToListOfInteger(apartment['features']),
      rating: apartment["rating"],
      images: [], // Images handling can be implemented as needed
    );
  }
  factory ApartmentType.empty() {
    return ApartmentType(
      city: "",
      town: "",
      space: 0.0,
      rooms: 0,
      priceForMonth: 0.0,
      description: "",
      features: [],
      images: [],
      idApartment: -1,
      idLandlord: -1,
      rating: 0,
    );
  }
}
