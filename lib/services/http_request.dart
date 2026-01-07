import 'dart:developer';
import 'dart:io';
import 'package:booking/helper/constant/api.dart';
import 'package:booking/helper/methods/authrization_headers.dart';
import 'package:booking/helper/methods/create_form_data.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/services/auth_storage.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/booking_apartment_type.dart';
import 'package:booking/types/filter_type.dart';
import 'package:booking/types/rate_type.dart';
import 'package:booking/types/user_register_type.dart';
import 'package:dio/dio.dart';

class HttpRequest {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: api,
      // connectTimeout: const Duration(seconds: 1),
      // receiveTimeout: const Duration(seconds: 1),
      headers: {'Accept': 'application/json'},
    ),
  );

  HttpRequest();
  // ************** for auth **************

  Future<Map<String, dynamic>> register(UserRegisterType user) async {
    try {
      printGreen(user.phone);
      printGreen(user.firstName);
      printGreen(user.lastName);
      printGreen(user.password ?? "false");
      printGreen(user.role.name);
      printGreen(user.birthday.toIso8601String().split("T")[0]);
      printGreen(user.profileImage.path);
      printGreen(user.idImage.path);
      final formData = FormData.fromMap({
        'phone': user.phone,
        'password': user.password,
        'first_name': user.firstName,
        'last_name': user.lastName,
        'role': user.role.name,
        'balance': 0,
        'birthday': user.birthday.toIso8601String().split("T")[0],
        'profile_image': await MultipartFile.fromFile(user.profileImage.path),
        'id_image': await MultipartFile.fromFile(user.idImage.path),
      });

      printRed("formData.fields.last");
      Response response = await dio.post('/register', data: formData);
      printGrey("Done Form HttpRequist");
      return {"success": true, "data": response.data};
    } on PathNotFoundException catch (_) {
      if (user.profileImage.path == "") {
        throw Exception("pls, enter profile image because is required .");
      } else if (user.idImage.path == "") {
        throw Exception("pls, enter id image because is required .");
      } else {
        throw Exception("try again enter either same or another image .");
      }
    } on DioException catch (e) {
      printYallow("**********");
      printRed(e.response.toString());
      printYallow("**********");
      printRed(e.type.name);
      printYallow("**********");
      printRed("DioException : $e");
      printYallow("**********");
      if (e.type.name == "connectionError") {
        throw Exception("Error Connection");
      } else if (e.type.name == "Cannot retrieve length of file") {
        throw Exception("image upload must be under 4 MG");
      } else if (e.response?.data["message"] != null) {
        throw Exception(e.response?.data["message"]);
      } else {
        throw Exception("e");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserRegisterType> login(Map<String, dynamic> user) async {
    try {
      Response response = await dio.post(
        "/login",
        data: {
          'phone': user["phone"].toString().substring(5),
          'password': user["password"],
        },
      );

      await AuthStorage().writeData("token", response.data["token"]);
      await AuthStorage().writeData("role", response.data["user"]["role"]);
      await AuthStorage().writeData("id_user", response.data["user"]["id"]);

      printGreen('token : ${response.data["token"]}');
      printGreen('response : ${response.data}');
      return UserRegisterType.fromJson(response.data["user"]);
    } on DioException catch (e) {
      printRed(e.response.toString());
      printYallow("**********");
      printRed(e.type.name);
      printYallow("**********");
      printRed("DioException : $e");

      if ((e.response?.statusCode ?? false) == 401) {
        throw Exception("phone or password wrong !!");
      }
      if ((e.response?.statusCode ?? false) == 404) {
        final message = (e.response?.data as Map<String, dynamic>)["message"]
            .toString();
        throw Exception(message);
      }
      throw Exception("Error Connection");
    } catch (e) {
      printRed("ERROR : $e");
      throw Exception("EEROR: $e");
    }
  }

  Future<void> logout() async {
    final token = await AuthStorage().readData("token");
    printBlueWithBold(token ?? "null");
    try {
      await dio.get(
        "/logout",
        options: Options(headers: authrizationHeaders(token ?? "")),
      );
      final String? mode = await AuthStorage().readData('mode');
      await AuthStorage().deleteAllData();
      await AuthStorage().writeData('mode', mode);
      printGreen("DONE");
    } catch (e) {
      printRed("ERROR : $e");
    }
  }

  // ************** for auth **************

  // ************** for admin **************

  Future<bool> deleteUserByID(int idUser) async {
    final String? token = await AuthStorage().readData("token");
    try {
      await dio.delete(
        "/deleteUser/$idUser",
        options: Options(headers: authrizationHeaders(token!)),
      );
      printGreen("DONE");
      return true;
    } on DioException catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    } catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    }
  }

  Future<bool> acceptUserByID(int idUser, bool isAccept) async {
    final String? token = await AuthStorage().readData("token");
    try {
      await dio.post(
        "/acceptUser/$idUser",
        data: {"isAccept": isAccept},
        options: Options(headers: authrizationHeaders(token!)),
      );
      printGreen("DONE");
      return true;
    } on DioException catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    } catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    }
  }

  Future<List<UserRegisterType>> getAllTemporaryUsers() async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/getAllTemporaryUsers",
        options: Options(headers: authrizationHeaders(token!)),
      );
      final List<dynamic> data = response.data;
      List<UserRegisterType> temporaryUsers = [];
      for (int i = 0; i < data.length; i++) {
        temporaryUsers.add(UserRegisterType.fromJson(data[i]));
      }
      printGreen("DONE");
      return temporaryUsers;
    } on DioException catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    } catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    }
  }

  Future<List<UserRegisterType>> allUsers() async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/allusers",
        options: Options(headers: authrizationHeaders(token!)),
      );
      final List<dynamic> data = response.data["users"];
      List<UserRegisterType> users = [];
      for (int i = 0; i < data.length; i++) {
        printGreen("DONE");
        users.add(UserRegisterType.fromJson(data[i]));
      }
      return users;
    } on DioException catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    } catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    }
  }

  Future<void> deleteUser(int id) async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.delete(
        "/deleteUser/$id",
        options: Options(headers: authrizationHeaders(token!)),
      );
      printGreen(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) printRed("this user not found !!");
      printRed(e.toString());
    } catch (e) {
      printRed(e.toString());
    }
  }

  Future<void> increaseUserBalanceByID(int id, double amount) async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.post(
        "/increaseBalance/$id",
        data: {"amount": amount},
        options: Options(headers: authrizationHeaders(token!)),
      );
      printGreen(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) printRed("e.response.toString()");
      printRed(e.toString());
    } catch (e) {
      printRed(e.toString());
    }
  }

  // ************** for admin **************

  // ************** for landlord **************

  Future<Map<String, dynamic>> confirmBookingByID(int id, bool isAccept) async {
    try {
      final String? token = await AuthStorage().readData('token');
      Response response = await dio.post(
        '/confirmBooking/$id',
        data: {'isAccept': isAccept},
        options: Options(headers: authrizationHeaders(token ?? "")),
      );
      printGreen(response.data.toString());
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      printRed('${e.response?.data}');
      printRed('${e.requestOptions.data}');
      printRed(e.type.name);
      throw Exception(e.toString());
    } catch (e) {
      printRed(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<BookingApartmentType>> getAllConfirmedBookingsLandlord() async {
    try {
      final String? token = await AuthStorage().readData('token');
      // printGreen(token!);
      Response response = await dio.get(
        '/ConfirmedBookingsLandlord',
        options: Options(headers: authrizationHeaders(token!)),
      );

      final List<dynamic> data = response.data['bookings'];
      final List<BookingApartmentType> confirmedBookingApartment = data
          .map((e) => BookingApartmentType.fromJson(e))
          .toList();
      return confirmedBookingApartment;
    } on DioException catch (e) {
      printRed(e.toString());
      throw Exception('${e.response?.data}');
    } catch (e) {
      printRed(e.toString());
      throw Exception(e);
    }
  }

  Future<ApartmentType> displayBookingsApartmentByID(
    int idApartment,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final String? token = await AuthStorage().readData("token");

    try {
      Response response = await dio.get(
        "/BookingsApartment/$idApartment",
        options: Options(
          headers: {
            ...authrizationHeaders(token!),
            "start_date": startDate,
            "end_date": endDate,
          },
        ),
      );

      printGreen(response.data.toString());
      return ApartmentType.fromJsonWithoutFavorite(response.data);
    } on DioException catch (e) {
      printRed("ERROR : ${e.response?.data.toString()}");
      throw Exception([e]);
    } catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    }
  }

  Future<List<ApartmentType>> getAllApartmentForLandLord() async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/apartment",
        options: Options(headers: authrizationHeaders(token!)),
      );
      final dynamic data = response.data;
      log(data.toString());
      List<ApartmentType> apaetments = [];
      if (data['apartment'] != null) {
        List<dynamic> apartments = data['apartment'];
        for (int i = 0; i < apartments.length; i++) {
          apaetments.add(ApartmentType.fromJsonWithoutFavorite(apartments[i]));
          printGrey(apaetments[i].city);
        }
      } else {
        throw Exception("don't arrive correct data");
      }
      printGreen(data.toString());
      return apaetments;
    } on DioException catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    } catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    }
  }

  Future<ApartmentType> getApartmentByIDForLandlord(int id) async {
    try {
      final String? token = await AuthStorage().readData('token');
      Response response = await dio.get(
        '/apartment/$id',
        options: Options(headers: authrizationHeaders(token ?? '')),
      );
      if (response.data['message'] != null) {
        throw Exception('${response.data['message']}');
      }
      printGreen('text');
      return ApartmentType.fromJsonWithoutFavorite(response.data['apartment']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addApartmentForLandlord(ApartmentType apartment) async {
    final String? token = await AuthStorage().readData("token");
    printRed('${apartment.images?.length}');
    final formData = await createFormData(apartment.images!, {
      'city': apartment.city,
      'town': apartment.town,
      'space': apartment.space,
      'rooms': apartment.rooms,
      'price_for_month': apartment.priceForMonth,
      'description': apartment.description,
      'features': apartment.features.toString(),
    });
    try {
      Response response = await dio.post(
        "/apartment",
        options: Options(headers: authrizationHeaders(token ?? "")),
        data: formData,
      );
      printGreen(response.data.toString());
    } on DioException catch (e) {
      printRed(e.response!.data.toString());
      throw Exception(e);
    } catch (e) {
      printRed(e.toString());
      throw Exception(e);
    }
  }

  Future<void> deleteApartmentForLandlord(int id) async {
    final String? token = await AuthStorage().readData("token");

    try {
      Response response = await dio.delete(
        "/apartment/$id",
        options: Options(headers: authrizationHeaders(token ?? "")),
      );
      printGreen(response.data.toString());
    } on DioException catch (e) {
      printRed(e.response!.data.toString());
      throw Exception(e);
    } catch (e) {
      printRed(e.toString());
      throw Exception(e);
    }
  }

  Future<void> updateApartmentForLandlord(ApartmentType apartment) async {
    final String? token = await AuthStorage().readData("token");
    final formData = await createFormData(apartment.images!, {
      'city': apartment.city,
      'town': apartment.town,
      'space': apartment.space,
      'rooms': apartment.rooms,
      'price_for_month': apartment.priceForMonth,
      'description': apartment.description,
      'features': apartment.features.toString(),
    });
    try {
      Response response = await dio.put(
        "/apartment",
        options: Options(headers: authrizationHeaders(token ?? "")),
        data: formData,
      );
      printGreen(response.data.toString());
    } on DioException catch (e) {
      printRed(e.response!.data.toString());
      throw Exception(e);
    } catch (e) {
      printRed(e.toString());
      throw Exception(e);
    }
  }

  Future<List<BookingApartmentType>> bookingsLandlord() async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/BookingsLandlord",
        options: Options(headers: authrizationHeaders(token ?? "")),
      );
      List<dynamic> data = response.data['bookings'];
      printWhite(data.toString());
      List<BookingApartmentType> requrestBooking = data
          .map((e) => BookingApartmentType.fromJson(e))
          .toList();
      log(requrestBooking.toString());
      return requrestBooking;
    } on DioException catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    } catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    }
  }

  // ************** for landlord **************

  // ************** for tenant **************

  Future<ApartmentType> getApartmentByIDForTenant(int idApartment) async {
    final token = await AuthStorage().readData("token");
    printYallow('id : $idApartment');
    try {
      Response response = await dio.get(
        '/apartments/Tenant/$idApartment',
        options: Options(headers: authrizationHeaders(token!)),
      );
      printGreen(response.data.toString());
      return ApartmentType.fromJsonWithFavorite(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      printRed('e.response.toString() : ${e.response.toString()}');
      return ApartmentType.empty();
    } catch (e) {
      printRed('Error fetching apartment by ID: $e');
      return ApartmentType.empty();
    }
  }

  Future<List<ApartmentType>> getAllApartementForTenant() async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/apartments/Tenant",
        options: Options(headers: authrizationHeaders(token ?? "")),
      );
      printRed(response.data.toString());

      final List<dynamic> data = response.data["apartments"];
      printGreen(data.toString());
      final List<ApartmentType> apartemnts = [];
      for (int i = 0; i < data.length; i++) {
        apartemnts.add(ApartmentType.fromJsonWithoutFavorite(data[i]));
      }
      return apartemnts;
    } on DioException catch (e) {
      printRed(e.type.name);
      printRed(e.response!.data.toString());
      // printRed(e.toString());
      if (e.type.name == 'connectionError') {
        throw Exception("No Internet 😢");
      } else if (e.response?.statusCode == 401 &&
          e.response?.data['message'] != null &&
          e.response!.data['message'] == 'Unauthenticated') {
        await AuthStorage().deleteAllData();
      }
      throw Exception(e.toString());
    } catch (e) {
      printYallow(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<ApartmentType>> getAllApartementForMostPopular() async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/apartments/latest",
        options: Options(headers: authrizationHeaders(token ?? "")),
      );

      final List<dynamic> data = response.data;
      printGreen(data.toString());
      final List<ApartmentType> apartemnts = [];
      for (int i = 0; i < data.length; i++) {
        apartemnts.add(ApartmentType.fromJsonWithoutFavorite(data[i]));
      }
      return apartemnts;
    } on DioException catch (e) {
      printRed(e.type.name);
      printRed(e.response!.data.toString());
      // printRed(e.toString());
      if (e.type.name == 'connectionError') {
        throw Exception("No Internet 😢");
      } else if (e.response?.statusCode == 401 &&
          e.response?.data['message'] != null &&
          e.response!.data['message'] == 'Unauthenticated') {
        await AuthStorage().deleteAllData();
      }
      throw Exception(e.toString());
    } catch (e) {
      printYallow(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> displayAvailableDateForParticularApartment(int id) async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/apartments/$id",
        options: Options(headers: authrizationHeaders(token!)),
      );
      printGreen(response.data.toString());
    } catch (e) {
      printRed(e.toString());
    }
  }

  Future<Map<String, dynamic>> bookingParticularApartmentByID(
    int id,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final String? token = await AuthStorage().readData("token");
    try {
      printGrey(startDate.toIso8601String().split("T")[0].toString());
      printGrey(endDate.toString());
      Response response = await dio.post(
        "/apartments/booking/$id",
        data: {
          "start_date": startDate.toIso8601String().split("T")[0],
          "end_date": endDate.toIso8601String().split("T")[0],
        },
        options: Options(headers: authrizationHeaders(token!)),
      );

      printGreen(response.data.toString());
      if ((response.data as Map<String, dynamic>)['message'] != null) {
        printRed(response.data['message']);
        throw Exception(response.data['message']);
      }
      if (response.data['id'] != null) {
        return {"success": true, "data": "Done send request to landlord"};
      }
      return response.data;
    } on DioException catch (e) {
      printYallow(e.response.toString());
      printYallow(e.error.toString());
      printYallow(e.message.toString());
      printYallow(e.type.name);
      if (e.response?.data['message'] != null) {
        throw Exception((e.response?.data as Map<String, dynamic>)["message"]);
      }
      throw Exception(e.response);
    } catch (e) {
      printRed(e.toString());

      throw Exception(e);
    }
  }

  Future<void> updateBookingParticularApartmentByID(
    int id,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      String? token = await AuthStorage().readData("token");
      Response response = await dio.put(
        '/apartments/booking/$id',
        options: Options(headers: authrizationHeaders(token ?? "")),
        data: {
          "start_date": startDate.toIso8601String().split("T")[0],
          "end_date": endDate.toIso8601String().split("T")[0],
        },
      );
      printGreen(response.data.toString());
    } catch (e) {
      printRed(e.toString());
    }
  }

  Future<void> deleteBookingParticularApartmentByID(int id) async {
    try {
      String? token = await AuthStorage().readData("token");
      Response response = await dio.delete(
        '/apartments/booking/$id',
        options: Options(headers: authrizationHeaders(token ?? "")),
      );
      printGreen(response.data.toString());
    } catch (e) {
      printRed(e.toString());
    }
  }

  Future<List<BookingApartmentType>> getAllbookingApartments() async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/apartments/booking",
        options: Options(headers: authrizationHeaders(token!)),
      );
      printGreen(response.data[0].toString());
      List<dynamic> data = response.data;
      List<BookingApartmentType> bookings = [];
      for (int i = 0; i < data.length; i++) {
        bookings.add(BookingApartmentType.fromJson(data[i]));
      }
      printGreen("DONE");
      return bookings;
    } on DioException catch (e) {
      printYallow(e.response.toString());
      printYallow(e.error.toString());
      printYallow(e.message.toString());
      printYallow(e.type.name);
      if (e.response?.statusCode == 400) {
        throw Exception((e.response?.data as Map<String, dynamic>)["message"]);
      }
      throw Exception(e.response);
    } catch (e) {
      printRed(e.toString());

      throw Exception(e);
    }
  }

  Future<bool> toggleFavoriteParticularApartmentByID(int id) async {
    try {
      final String? token = await AuthStorage().readData("token");
      await dio.post(
        "/apartments/toggleFavourite/$id",
        options: Options(headers: authrizationHeaders(token!)),
      );
      return true;
    } on DioException catch (e) {
      if (e.type.name == "connectionError") {
        throw Exception("connection error");
      }
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ApartmentType>> getFavoriteApartments() async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/apartments/favorites",
        options: Options(headers: authrizationHeaders(token!)),
      );
      final List<dynamic> data = response.data["Favorites"];
      printGreen(data.toString());
      final List<ApartmentType> favorite = [];
      for (int i = 0; i < data.length; i++) {
        favorite.add(ApartmentType.fromJsonWithoutFavorite(data[i]));
      }
      return favorite;
    } catch (e) {
      printYallow(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<ApartmentType>> filterApartment(FilterType filter) async {
    final String? token = await AuthStorage().readData("token");
    try {
      final String query =
          'city=${filter.city}&${filter.town != null ? 'town=${filter.town}&' : ""}min_price=${filter.minPrice}&max_price=${filter.maxPrice}&rooms=${filter.minRooms}&min_rating=${filter.minRating}&min-space=${filter.minSpace}&max-space=${filter.maxSpace}';
      Response response = await dio.get(
        "/apartments/filter?$query",
        options: Options(headers: authrizationHeaders(token ?? "")),
      );
      printGreen(response.data.toString());
      final List<dynamic> data = response.data['apartments'];
      final List<ApartmentType> apartments = [];
      for (int i = 0; i < data.length; i++) {
        apartments.add(ApartmentType.fromJsonWithoutFavorite(data[i]));
      }
      return apartments;
    } catch (e) {
      printRed(e.toString());
      throw Exception(e);
    }
  }

  Future<void> rateApartmentByID(int idApartment, RateType user) async {
    try {
      printGreen(user.rate.toString());
      if (user.rate == 0 && user.comment == null) {
        throw Exception("enter comment or rate one at leatest");
      }
      final String? token = await AuthStorage().readData("token");
      await dio.post(
        "/apartments/rate/$idApartment",
        options: Options(headers: authrizationHeaders(token ?? "")),
        data: user.rate == 0
            ? {'comment': user.comment}
            : user.comment == null
            ? {'rate': user.rate}
            : {'rate': user.rate, 'comment': user.comment},
      );
      // printGreen(response.data.toString());
    } on DioException catch (e) {
      printRed(e.response!.data.toString());
      if (e.response!.data['message'] != null) {
        throw Exception(e.response!.data['message'].toString());
      }
      throw Exception(e.response!.data.toString());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<RateType>> getAllRateForParticularApartmentByID(
    int idApartment,
  ) async {
    try {
      final String? token = await AuthStorage().readData("token");
      Response response = await dio.get(
        '/reviews/$idApartment',
        options: Options(headers: authrizationHeaders(token!)),
      );
      final List<dynamic> data = response.data['revewis'];
      printYallow(data.toString());
      final List<RateType> revewis = [];
      for (int i = 0; i < data.length; i++) {
        revewis.add(RateType.fromJson(data[i]));
      }
      return revewis;
    } on DioException catch (e) {
      printRed(e.requestOptions.data.toString());
      throw Exception(e);
    } catch (e) {
      printRed(e.toString());
      throw Exception(e);
    }
  }

  // ************** for tenant **************

  // ************** for any user **************

  Future<UserRegisterType> fetchUserByID(int id) async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/profile/$id",
        options: Options(headers: authrizationHeaders(token!)),
      );
      printGreen(response.data.toString());
      return UserRegisterType.fromJson(response.data["user"]);
    } on DioException catch (e) {
      printRed("text");
      throw Exception(e.response);
    } catch (e) {
      printRed("text");
      throw Exception(e.toString());
    }
  }

  // ************** for any user **************
}
