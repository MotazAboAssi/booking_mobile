import 'package:booking/helper/constant/api.dart';
import 'package:booking/helper/methods/authrization_headers.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/services/auth_storage.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/user_login_type.dart';
import 'package:booking/types/user_register_type.dart';
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

  // under maintainus
  Future<Map<String, dynamic>> register(UserRegisterType user) async {
    try {
      FormData formData = FormData.fromMap({
        'phone': user.phone,
        'password': user.password,
        'first_name': user.firstName,
        'last_name': user.lastName,
        'role': user.role.name,
        'birthday': user.birthday.toIso8601String().split("T")[0],
        'profile_image': await MultipartFile.fromFile(
          user.profileImage.path,
          filename: user.profileImage.name,
        ),
        'id_image': await MultipartFile.fromFile(
          user.idImage.path,
          filename: user.idImage.name,
        ),
      });
      Response response = await dio.post(
        '/register',
        data: formData,
        options: Options(headers: {"Accept": 'application/json'}),
      );
      return {"success": true, "data": response.data.toString()};
    } catch (e) {
      printBlueWithBold("text");
      return {"success": false, "data": e.toString()};
    }
  }

  Future<void> login(UserLoginType user) async {
    try {
      Response response = await dio.post(
        "/login",
        data: {'phone': user.phone, 'password': user.password},
        options: Options(),
      );
      await AuthStorage().writeData("token", response.data["token"]);
      printGreen('token : ${response.data["token"]}');
    } catch (e) {
      printRed("ERROR : $e");
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
        printWhite(temporaryUsers[0].password);
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
