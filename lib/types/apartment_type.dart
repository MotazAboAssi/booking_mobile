import 'package:booking/helper/methods/convert_string_to_list_of_integer.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/types/image_from_apartment.dart';

class ApartmentType {
  int idApartment;
  int idLandlord;
  int rating;
  String city;
  String town;
  int space;
  int rooms;
  String? location;
  int priceForMonth;
  String description;
  List<int> features;
  List<ImageFromApartment>? images;
  bool? isFavorite;

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
    required this.isFavorite,
  });

  factory ApartmentType.fromJsonWithFavorite(Map<String, dynamic> json) {
    final apartment = json['apartment'];
    final isFavorite = json['is_favorite'];
    List<ImageFromApartment> pictures = [];
    List<dynamic>? arrImg = apartment["images"];
    for (int i = 0; i < (arrImg?.length ?? 0); i++) {
      pictures.add(ImageFromApartment.fromJson(arrImg![i]));
    }
    printBlueWithBold(json["rating"].toString());
    printBlueWithBold(json.toString());
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
      rating: double.parse(apartment["rating"].toString()).floor(),
      images: pictures,
      isFavorite: isFavorite,
    );
  }

  factory ApartmentType.fromJsonWithoutFivorite(Map<String, dynamic> json) {
    List<ImageFromApartment> pictures = [];
    List<dynamic>? arrImg = json["images"];
    for (int i = 0; i < (arrImg?.length ?? 0); i++) {
      pictures.add(ImageFromApartment.fromJson(arrImg![i]));
    }
    printBlueWithItalic(json.toString());
    return ApartmentType(
      idApartment: json["id"],
      idLandlord: json["user_id"],
      city: json['city'],
      town: json['town'],
      space: json['space'],
      rooms: json['rooms'],
      location: json['location'],
      priceForMonth: json['price_for_month'],
      description: json['description'],
      features: convertStringToListOfInteger(json['features']),
      rating:  double.parse(json["rating"].toString()).floor(),
      images: pictures,
      isFavorite: false,
    );
  }
  factory ApartmentType.empty() {
    return ApartmentType(
      city: "",
      town: "",
      space: 0,
      rooms: 0,
      priceForMonth: 0,
      description: "",
      features: [],
      images: [],
      idApartment: -1,
      idLandlord: -1,
      rating: 0,
      isFavorite: false,
    );
  }
}
