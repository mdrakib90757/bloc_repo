import 'package:dio/dio.dart';
import 'package:serialman_app/data/model/service_center_model/service_center_model.dart';
import 'package:serialman_app/data/repository/service_center_repository/service_center_repository.dart';
import 'package:serialman_app/feature/service_center/data/request_model/add_button_request.dart';

import '../../../../data/provider/service_center_add_button_api/service_center_add_button_api.dart';

class ServiceCenterRepositoryImpl
    implements ServiceCenterAddButtonRepo, fetchServiceCenterAddButtonRepo {
  final ServiceCenterApi serviceCenterApi;
  ServiceCenterRepositoryImpl(this.serviceCenterApi);

  @override
  Future<void> createServiceCenterAddButton(
    String companyId,
    AddButtonRequest request,
  ) async {
    try {
      final response = await serviceCenterApi.createServiceCenterAddButton(
        request,
        companyId,
      );
      if (response.statusCode != 200) {
        throw Exception(
          "Failed to create service center. Status: ${response.statusCode}, Data: ${response.data}",
        );
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data ?? "Unknown error during service center creation",
      );
    }
  }

  @override
  Future<ServiceCenterModel> fetchServiceCenterAddButton(
    String companyId,
  ) async {
    try {
      final serviceCenter = await serviceCenterApi.fetchServiceCenterAddButton(
        companyId,
      );
      return serviceCenter;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Unknow error");
    }
  }
}
