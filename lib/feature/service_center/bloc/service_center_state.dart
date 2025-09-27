import 'package:serialman_app/data/model/service_center_model/service_center_model.dart';

abstract class ServiceCenterState {}

class ServiceCenterInitial extends ServiceCenterState {}

class ServiceCenterLoading extends ServiceCenterState {}

class ServiceCenterSuccess extends ServiceCenterState {}

class ServiceCenterSuccessWithData extends ServiceCenterState {
  final ServiceCenterModel serviceCenterModel;
  ServiceCenterSuccessWithData(this.serviceCenterModel);
}

class ServiceCenterFailure extends ServiceCenterState {
  final String message;
  ServiceCenterFailure(this.message);
}
