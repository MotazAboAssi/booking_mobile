import 'package:booking/helper/methods/convert_string_to_list_of_integer.dart';
import 'package:booking/types/image_from_apartment.dart';

class ApartmentWithBookingType {
  String city;
  String town;
  String description;
  List<ImageFromApartment>? images;

  ApartmentWithBookingType({
    required this.city,
    required this.town,
    required this.description,
    required this.images,
  });

  factory ApartmentWithBookingType.fromJsonWithoutFivorite(
    Map<String, dynamic> json,
  ) {
    
    List<ImageFromApartment> pictures = [];
    List<dynamic>? arrImg = json["images"];
    for (int i = 0; i < (arrImg?.length ?? 0); i++) {
      pictures.add(ImageFromApartment.fromJson(arrImg![i]));
    }
    return ApartmentWithBookingType(
      city: json['city'],
      town: json['town'],
      description: json['description'],
      images: pictures,
    );
  }
  factory ApartmentWithBookingType.empty() {
    return ApartmentWithBookingType(
      city: "",
      town: "",
      description: "",
      images: [],
    );
  }
}
