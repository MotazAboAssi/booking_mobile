import 'package:booking/helper/constant/api.dart';
import 'package:booking/helper/test/print.dart';
import 'package:dio/dio.dart';

class HttpRequest {
  static final Dio dio = Dio(
    // BaseOptions(
    //   // baseUrl: baseURL,
    //   // connectTimeout: 5000,
    //   // receiveTimeout: 3000,
    //   // headers: {
    //   //  ,

    //     // 'Accept': 'application/json',
    //   },
    // ),
  );

  HttpRequest();

  Future<void> getMostPopularApartments() async {
    try {
      Response response = await dio.get(
        '$API/apartments',
        // options: Options(
        //   headers: {
        //     'Authorization': 'Bearer $tokenLandlord',
        //     'User-Agent': 'no-cache',
        //     'Cache-Control': 'PostmanRuntime/7.49.1',
        //     'Content-Type': 'application/json',
        //   },
        // ),
      );
      printGreen(response.data.toString());
    } catch (e) {
      printRed('Error fetching most popular apartments: $e');
    }
  }
}
