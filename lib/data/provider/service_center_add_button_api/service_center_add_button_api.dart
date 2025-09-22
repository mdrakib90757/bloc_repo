import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:serialman_app/core/network/dio_client.dart';
import 'package:serialman_app/feature/service_center/data/request_model/add_button_request.dart';

import '../../model/service_center_model/service_center_model.dart';

class ServiceCenterApi{
  final DioClient _client = DioClient();


  // add button
  Future<Response>createServiceCenterAddButton(AddButtonRequest request,String companyId)async{
    final String body = jsonEncode(request.toJson());
    return _client.dio.post("/serial-no/companies/$companyId/service-centers",
        data: body,
    options:Options(headers: await _client.getHeaders())
    );
  }


Future<ServiceCenterModel>fetchServiceCenterAddButton(String companyId)async{
    final response = await _client.dio.get("/serial-no/companies/$companyId/service-centers");
    return ServiceCenterModel.fromJson(response.data);
}


}