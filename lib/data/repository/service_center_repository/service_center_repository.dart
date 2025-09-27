import 'package:serialman_app/data/model/service_center_model/service_center_model.dart';

import '../../../feature/service_center/data/request_model/add_button_request.dart';

abstract class ServiceCenterAddButtonRepo {
  Future<void> createServiceCenterAddButton(
    String companyId,
    AddButtonRequest request,
  );
}

abstract class fetchServiceCenterAddButtonRepo {
  Future<ServiceCenterModel> fetchServiceCenterAddButton(String companyId);
}
