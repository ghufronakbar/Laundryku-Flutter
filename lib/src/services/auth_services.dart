import 'package:dio/dio.dart';
import 'package:laundryku/src/models/api_response.dart';
import 'package:laundryku/src/models/auth.dart';
import 'package:laundryku/src/utils/constants.dart';
import 'package:laundryku/src/utils/dio_client.dart';
import 'package:laundryku/src/utils/regex.dart';
import 'package:laundryku/src/utils/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  DioClient dioClient = DioClient();

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.accessToken);
  }

  Future<void> login(String email, String password, bool loading,
      void Function(bool loading) setLoading, Function afterSuccess) async {
    if (loading) {
      return;
    }

    if (email.isEmpty || password.isEmpty) {
      Toast().err(message: "Semua field harus diisi");
      return;
    }

    setLoading(true);

    var data = {"email": email, "password": password};

    try {
      Response<Map<String, dynamic>> response = await dioClient.dio
          .post<Map<String, dynamic>>("/auth/login", data: data);

      ApiResponse<Auth> parsedResponse = ApiResponse.fromJson(
        response.data!,
        (data) => Auth.fromJson(data),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          Constants.accessToken, parsedResponse.data.accessToken);

      Toast().success(message: parsedResponse.message);
      afterSuccess();
    } on DioException catch (e) {
      Toast().err(message: e.response?.data['message'] ?? "Terjadi kesalahan");
    } finally {
      setLoading(false);
    }
  }

  Future<void> register(
      String name,
      String phone,
      String email,
      String password,
      String confirmPassword,
      bool loading,
      void Function(bool loading) setLoading,
      Function afterSuccess) async {
    if (loading) {
      return;
    }

    if (name.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Toast().err(message: "Semua field harus diisi");
      return;
    }

    if (!Regex().validateEmail(email)) {      
      Toast().err(message: "Email tidak valid");
      return;
    }

    if (password.length < 6) {
      Toast().err(message: "Password minimal 6 karakter");
      return;
    }

    if (password != confirmPassword) {
      Toast().err(message: "Konfirmasi password tidak sama");
      return;
    }

    setLoading(true);

    var data = {
      "email": email,
      "password": password,
      "name": name,
      "phone": phone
    };

    try {
      Response<Map<String, dynamic>> response = await dioClient.dio
          .post<Map<String, dynamic>>("/auth/register", data: data);

      ApiResponse<Auth> parsedResponse = ApiResponse.fromJson(
        response.data!,
        (data) => Auth.fromJson(data),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          Constants.accessToken, parsedResponse.data.accessToken);

      Toast().success(message: parsedResponse.message);
      afterSuccess();
    } on DioException catch (e) {
      Toast().err(message: e.response?.data['message'] ?? "Terjadi kesalahan");
    } finally {
      setLoading(false);
    }
  }

  Future<void> logout(Function goTo) async {
    goTo();
    Toast().success(message: "Logout berhasil");
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
