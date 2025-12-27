import 'dart:io';
import 'package:booking/helper/constant/api.dart';
import 'package:booking/helper/methods/authrization_headers.dart';
import 'package:booking/helper/methods/create_form_data.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/views/favorite_apartments_view.dart';
import 'package:booking/services/auth_storage.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/user_register_type.dart';
import 'package:dio/dio.dart';

class HttpRequest {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: api,
      // connectTimeout: const Duration(seconds: 10),
      // receiveTimeout: const Duration(seconds: 10),
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
      await AuthStorage().deleteAllData();
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

  // ************** for admin **************

  // ************** for landlord **************

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
      return ApartmentType.fromJson(response.data);
    } on DioException catch (e) {
      printRed("ERROR : ${e.response?.data.toString()}");
      throw Exception([e]);
    } catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    }
  }

  Future<List<ApartmentType>> apartment() async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/apartment",
        options: Options(headers: authrizationHeaders(token!)),
      );
      final List<dynamic> data = response.data;
      List<ApartmentType> apaetments = [];
      for (int i = 0; i < data.length; i++) {
        apaetments.add(ApartmentType.fromJson(data[i]));
        printGrey(apaetments[i].city);
      }
      printGreen("DONE");
      return apaetments;
    } on DioException catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    } catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    }
  }

  Future<void> addApartmentForLandlord(ApartmentType apartment) async {
    final String? token = await AuthStorage().readData("token");
    final formData = await createFormData(apartment.images!, {});
    try {
      Response response = await dio.post(
        "$api/apartment?city=${apartment.city}&town=${apartment.town}&space=${apartment.space}&rooms=${apartment.rooms}&price_for_month=${apartment.priceForMonth}&description=${apartment.description}&features=${apartment.features.toString()}",
        options: Options(headers: authrizationHeaders(token ?? "")),
        data: formData,
      );
      printGreen(response.data);
    } catch (e) {
      printRed(e.toString());
      throw Exception(e);
    }
  }

  // ************** for landlord **************

  // ************** for tenant **************

  // Future<ApartmentType> bookingsLandlord() async {
  //   final String? token = await AuthStorage().readData("token");
  //   try {
  //     Response response = await dio.get(
  //       "/BookingsLandlord",
  //       options: Options(headers: authrizationHeaders(token ?? "")),
  //     );
  //     return ApartmentType.fromJson(response.data);
  //   } on DioException catch (e) {
  //     printRed("ERROR : $e");
  //     throw Exception([e]);
  //   } catch (e) {
  //     printRed("ERROR : $e");
  //     throw Exception([e]);
  //   }
  // }

  Future<ApartmentType> getApartmentByID(int idApartment) async {
    final token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        '/apartment/Tenant/$idApartment',
        options: Options(headers: authrizationHeaders(token!)),
      );
      printGreen(response.data.toString());
      return ApartmentType.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      printRed('Error fetching apartment by ID: $e');
      return ApartmentType.empty();
    }
  }

  Future<List<ApartmentType>> getAllApartementForTenant() async {
    final String? token = await AuthStorage().readData("token");
    printGreen(token!);
    try {
      Response response = await dio.get(
        "/apartments/Tenant",
        options: Options(headers: authrizationHeaders(token)),
      );
      final List<dynamic> data = response.data["apartments"];
      printGreen(data.toString());
      final List<ApartmentType> apartemnts = [];
      for (int i = 0; i < data.length; i++) {
        apartemnts.add(ApartmentType.fromJson(data[i]));
      }
      return apartemnts;
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode == 403) {
        throw Exception("wrong login again login");
      }
      throw Exception("Error Connection");
    } catch (e) {
      throw Exception(e);
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
      return {"success": true, "data": response.data.toString()};
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
      final List<ApartmentType> favorite = [];
      // printGreen(response.data.toString());
      for (int i = 0; i < data.length; i++) {
        favorite.add(ApartmentType.fromJson(data[i]));
      }
      return favorite;
    } catch (e) {
      printYallow(e.toString());
      throw Exception(e.toString());
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
      return UserRegisterType.fromJson(response.data["user"]);
    } on DioException catch (e) {
      throw Exception(e.response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // ************** for any user **************
}
