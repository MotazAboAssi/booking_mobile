import 'package:booking/helper/constant/api.dart';
import 'package:booking/helper/methods/authrization_headers.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:dio/dio.dart';

class HttpRequest {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: API,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  HttpRequest();

  Future<ApartmentType> getApartmentByID(int idApartment) async {
    try {
      Response response = await dio.get(
        '$API/apartment/Tenant/$idApartment',
        options: Options(headers: authrizationHeaders(tokenTenant)),
      );
      printGreen(response.data.toString());
      return ApartmentType.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      printRed('Error fetching apartment by ID: $e');
      return ApartmentType.empty();
    }
  }
}
