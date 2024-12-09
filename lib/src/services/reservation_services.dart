import 'package:dio/dio.dart';
import 'package:laundryku/src/models/api_response.dart';
import 'package:laundryku/src/models/checkout.dart';
import 'package:laundryku/src/models/detail_reservation.dart';
import 'package:laundryku/src/models/reservation.dart';
import 'package:laundryku/src/utils/dio_client.dart';
import 'package:laundryku/src/utils/toast.dart';

class ReservationServices {
  DioClient dioClient = DioClient();

  Future<ReservationData> getHistories() async {
    Response<Map<String, dynamic>> response =
        await dioClient.dio.get<Map<String, dynamic>>("/reservations");

    ApiResponse<ReservationData> parsedResponse = ApiResponse.fromJson(
      response.data!,
      (data) => ReservationData.fromJson(data),
    );
    return parsedResponse.data;
  }

  Future<DetailReservation> getDetailHistory(String id) async {
    Response<Map<String, dynamic>> response =
        await dioClient.dio.get<Map<String, dynamic>>("/reservations/$id");

    ApiResponse<DetailReservation> parsedResponse = ApiResponse.fromJson(
      response.data!,
      (data) => DetailReservation.fromJson(data),
    );
    return parsedResponse.data;
  }

  Future<void> cancelReservation(String id, bool loading,
      void Function(bool loading) setLoading, Function afterSuccess) async {
    if (loading) {
      return;
    }
    setLoading(true);
    try {
      await dioClient.dio.patch<Map<String, dynamic>>("/reservations/$id");

      Toast().success(message: "Berhasil membatalkan reservasi");
      afterSuccess();
    } on DioException catch (e) {
      Toast().err(message: e.response?.data['message'] ?? "Terjadi kesalahan");
    } finally {
      setLoading(false);
    }
  }

  Future<String?> checkout(
      String machineType,
      String machineNumber,
      String date,
      String time,
      bool loading,
      void Function(bool loading) setLoading) async {
    if (loading) {
      return null;
    }

    String formattedDate = date.substring(0, 10);

    var data = {
      "machine_type": machineType,
      "machine_number": machineNumber,
      "date": formattedDate,
      "time": time
    };
    try {
      setLoading(true);
      Response<Map<String, dynamic>> response = await dioClient.dio
          .post<Map<String, dynamic>>("/reservations", data: data);

      ApiResponse<Checkout> parsedResponse = ApiResponse.fromJson(
        response.data!,
        (data) => Checkout.fromJson(data),
      );
      Toast().success(message: "Berhasil melakukan reservasi");
      return parsedResponse.data.id;
    } on DioException catch (e) {
      Toast().err(message: e.response?.data['message'] ?? "Terjadi kesalahan");
      return null;
    } finally {
      setLoading(false);
    }
  }
}
