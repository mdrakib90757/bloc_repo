import 'package:bloc/bloc.dart';
import 'package:serialman_app/data/model/service_center_model/service_center_model.dart';
import 'package:serialman_app/feature/service_center/bloc/service_center_event.dart';
import 'package:serialman_app/feature/service_center/bloc/service_center_state.dart';
import 'package:serialman_app/feature/service_center/data/repository_impl/service_center_repository_impl.dart';

class ServiceCenterBloc extends Bloc<ServiceCenterEvent, ServiceCenterState> {
  final ServiceCenterRepositoryImpl serviceCenterRepositoryImpl;

  ServiceCenterBloc(this.serviceCenterRepositoryImpl)
    : super(ServiceCenterInitial()) {
    on<createServiceCenterAddButtonEvent>((event, emit) async {
      emit(ServiceCenterLoading());
      try {
        await serviceCenterRepositoryImpl.createServiceCenterAddButton(
          event.companyId,
          event.request,
        );
        emit(ServiceCenterSuccess());
      } catch (e) {
        emit(ServiceCenterFailure(e.toString()));
      }
    });

    on<fetchServiceCenterAddButtonEvent>((event, emit) async {
      emit(ServiceCenterLoading());
      try {
        await serviceCenterRepositoryImpl.fetchServiceCenterAddButton(
          event.companyId,
        );
        // emit(ServiceCenterSuccessWithData(serviceCenterModel));
      } catch (e) {
        emit(ServiceCenterFailure(e.toString()));
      }
    });
  }
}
