class ImageFromApartment {
  final int id;
  final int idApartment;
  final String image;

  ImageFromApartment({
    required this.id,
    required this.idApartment,
    required this.image,
  });
  factory ImageFromApartment.fromJson(Map<String, dynamic> json) {
    return ImageFromApartment(
      id: json["id"],
      idApartment: json["apartment_id"],
      image: json["image"],
    );
  }
}
