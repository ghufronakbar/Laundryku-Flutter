import 'package:dio/dio.dart';
import 'package:laundryku/src/models/api_response.dart';
import 'package:laundryku/src/models/detail_machine.dart';
import 'package:laundryku/src/models/machine.dart';
import 'package:laundryku/src/utils/dio_client.dart';

class MachineServices {
  DioClient dioClient = DioClient();

  Future<MachineData> getStatusMachine() async {
    Response<Map<String, dynamic>> response =
        await dioClient.dio.get<Map<String, dynamic>>("/machines");

    ApiResponse<MachineData> parsedResponse = ApiResponse.fromJson(
      response.data!,
      (data) => MachineData.fromJson(data),
    );
    return parsedResponse.data;
  }

  Future<DetailMachineData> getStatusPerMachineDate(
      String type, String date, String machineNumber) async {
      String formattedDate = date.substring(0, 10);


    var queryParameters = {'date': formattedDate, 'machine_number': machineNumber};
    print(queryParameters);
    print("type :" + type);
    Response<Map<String, dynamic>> response = await dioClient.dio
        .get<Map<String, dynamic>>("/machines/$type",
            queryParameters: queryParameters);

    ApiResponse<DetailMachineData> parsedResponse = ApiResponse.fromJson(
      response.data!,
      (data) => DetailMachineData.fromJson(data),
    );
    return parsedResponse.data;
  }
}
