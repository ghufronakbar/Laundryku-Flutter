import 'dart:io';

import 'package:dio/dio.dart';
import 'package:laundryku/src/models/api_response.dart';
import 'package:laundryku/src/models/user.dart';
import 'package:laundryku/src/utils/dio_client.dart';
import 'package:laundryku/src/utils/regex.dart';
import 'package:laundryku/src/utils/toast.dart';

class AccountServices {
  DioClient dioClient = DioClient();

  Future<User> getProfle() async {
    Response<Map<String, dynamic>> response =
        await dioClient.dio.get<Map<String, dynamic>>("/profile");

    ApiResponse<User> parsedResponse = ApiResponse.fromJson(
      response.data!,
      (data) => User.fromJson(data),
    );
    return parsedResponse.data;
  }

  Future<void> editProfile(
    String name,
    String phone,
    String email,
    bool loading,
    void Function(bool loading) setLoading,
  ) async {
    if (loading) {
      return;
    }

    if (name.isEmpty || phone.isEmpty || email.isEmpty) {
      Toast().err(message: "Semua field harus diisi");
      return;
    }

    if (!Regex().validateEmail(email)) {
      Toast().err(message: "Email tidak valid");
      return;
    }

    setLoading(true);

    var data = {"email": email, "name": name, "phone": phone};

    try {
      Response<Map<String, dynamic>> response =
          await dioClient.dio.put<Map<String, dynamic>>("/profile", data: data);

      ApiResponse<User> parsedResponse = ApiResponse.fromJson(
        response.data!,
        (data) => User.fromJson(data),
      );

      Toast().success(message: parsedResponse.message);
    } on DioException catch (e) {
      Toast().err(message: e.response?.data['message'] ?? "Terjadi kesalahan");
    } finally {
      setLoading(false);
    }
  }

  Future<void> editPicture(
    File pic,
    Function(String imageUrl) setImageUrl,
  ) async {
    Toast().loading();
    // Gunakan FormData untuk mengirimkan gambar
    FormData formData = FormData.fromMap({
      "profile_picture": await MultipartFile.fromFile(
        pic.path,
        filename: pic.uri.pathSegments.last, // Nama file gambar
      ),
    });

    try {
      Response<Map<String, dynamic>> response =
          await dioClient.dio.post<Map<String, dynamic>>(
        "/profile", // pastikan endpoint sesuai
        data: formData,
      );

      // Mengparse response
      ApiResponse<User> parsedResponse = ApiResponse.fromJson(
        response.data!,
        (data) => User.fromJson(data),
      );

      setImageUrl(parsedResponse.data.imageUrl ?? "");

      // Menampilkan toast sukses
      Toast().success(message: parsedResponse.message);
    } on DioException catch (e) {
      // Menangani error
      Toast().err(message: e.response?.data['message'] ?? "Terjadi kesalahan");
    } finally {
      // Menyelesaikan loading state
    }
  }

  Future<void> deletePicture(Function(String? imageUrl) setImageUrl) async {
    try {
      setImageUrl(null);
      Toast().success(message: "Berhasil menghapus foto");

      await dioClient.dio.delete<Map<String, dynamic>>(
        "/profile",
      );

    } on DioException catch (e) {
      Toast().err(message: e.response?.data['message'] ?? "Terjadi kesalahan");
    } finally {}
  }
}
