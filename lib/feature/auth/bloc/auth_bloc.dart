import 'package:bloc/bloc.dart';
import 'package:serialman_app/feature/auth/bloc/auth_event.dart';
import 'package:serialman_app/feature/auth/bloc/auth_state.dart';
import 'package:serialman_app/feature/auth/data/repository/auth_repository_impl.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl repositoryImpl;

  AuthBloc(this.repositoryImpl) : super(AuthInitial()) {
    // Service Center registration
    on<RegistrationServiceCenterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await repositoryImpl.registerServiceCenter(event.request);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // Service Taker registration
    on<RegisterServiceTakerEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await repositoryImpl.registerServiceTaker(event.request);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // Login
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await repositoryImpl.Login(event.request);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LoadBusinessTypesEvent>((event, emit) async {
      emit(BusinessTypeLoading());
      try {
        final businessTypes = await repositoryImpl.fetchBusinessTypes();
        emit(BusinessTypeLoaded(businessTypes));
      } catch (e) {
        emit(BusinessTypeError(e.toString()));
      }
    });
  }
}
