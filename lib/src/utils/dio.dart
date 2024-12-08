import "package:dio/dio.dart";
import "package:laundryku/src/utils/constants.dart";
import "package:laundryku/src/utils/toast.dart";
import "package:shared_preferences/shared_preferences.dart";

// Fungsi untuk mengambil token dari SharedPreferences
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(Constants.accessToken);
}

class DioClient {
  Dio dio;

  DioClient() : dio = Dio(BaseOptions(baseUrl: Constants.baseUrl)) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await getToken();
        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException error, handler) {
        Toast().err(message: error.message ?? "Terjadi kesalahan");
        return handler.next(error);
      },
    ));
  }
}
