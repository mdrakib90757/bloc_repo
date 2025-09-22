
import 'package:serialman_app/data/model/service_center_model/service_center_model.dart';
import 'package:serialman_app/feature/service_center/data/request_model/add_button_request.dart';

abstract class ServiceCenterEvent{}

class createServiceCenterAddButtonEvent extends ServiceCenterEvent{
  final AddButtonRequest request;
  final String companyId;
  createServiceCenterAddButtonEvent(this.request,this.companyId);
}


class fetchServiceCenterAddButtonEvent extends ServiceCenterEvent{
  final String companyId;
fetchServiceCenterAddButtonEvent(this.companyId);
}