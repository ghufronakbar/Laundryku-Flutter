import 'package:dio/dio.dart';
import 'package:laundryku/src/models/api_response.dart';
import 'package:laundryku/src/models/reservation.dart';
import 'package:laundryku/src/utils/dio_client.dart';

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
}
