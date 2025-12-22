class ImageFromApartment {
   int id;
   int idApartment;
   String image;

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
