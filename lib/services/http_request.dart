import 'dart:io';
import 'package:booking/helper/constant/api.dart';
import 'package:booking/helper/methods/authrization_headers.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/services/auth_storage.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/user_register_type.dart';
import 'package:dio/dio.dart';

class HttpRequest {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://$ip4:8080/api',
      connectTimeout: const Duration(seconds: 25),
      receiveTimeout: const Duration(seconds: 25),
      headers: {
        //   'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  HttpRequest();

  // under maintainus
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
      } else if (user.profileImage.path != "") {
        throw Exception("pls, try again enter profile image .");
      } else if (user.idImage.path == "") {
        throw Exception("pls, enter id image because is required .");
      } else if (user.idImage.path != "") {
        throw Exception("pls, try again enter id image .");
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
        options: Options(),
      );

      await AuthStorage().writeData("token", response.data["token"]);
      printGreen('token : ${response.data["token"]}');
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
      await AuthStorage().deleteData("token");
      printGreen("DONE");
    } catch (e) {
      printRed("ERROR : $e");
    }
  }

  Future<List<UserRegisterType>> getAllTemporaryUsers() async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/getAllTemporaryUsers",
        options: Options(headers: authrizationHeaders(token ?? "")),
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

  Future<bool> acceptUserByID(int idUser, bool isAccept) async {
    final String? token = await AuthStorage().readData("token");
    try {
      await dio.post(
        "/acceptUser/$idUser",
        data: {"isAccept": isAccept},
        options: Options(headers: authrizationHeaders(token ?? "")),
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

  Future<List<UserRegisterType>> allUsers() async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/allusers",
        options: Options(headers: authrizationHeaders(token ?? "")),
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

  Future<List<ApartmentType>> apartment() async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/apartment",
        options: Options(headers: authrizationHeaders(token ?? "")),
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

  Future<ApartmentType> bookingsApartmentByID(int idApartment) async {
    final String? token = await AuthStorage().readData("token");
    try {
      Response response = await dio.get(
        "/BookingsApartment/$idApartment",
        options: Options(headers: authrizationHeaders(token ?? "")),
      );
      return ApartmentType.fromJson(response.data);
    } on DioException catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    } catch (e) {
      printRed("ERROR : $e");
      throw Exception([e]);
    }
  }

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
}
