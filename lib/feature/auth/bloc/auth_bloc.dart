import 'package:bloc/bloc.dart';
import 'package:serialman_app/feature/auth/bloc/auth_event.dart';
import 'package:serialman_app/feature/auth/bloc/auth_state.dart';
import 'package:serialman_app/feature/auth/data/repository/auth_repository_impl.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl repositoryImpl;

  AuthBloc(this.repositoryImpl) : super(AuthInitial()) {
    // Handler for Registration Event
    on<RegistrationServiceCenterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await repositoryImpl.registerServiceCenter(event.request);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // Handler for Login Event
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await repositoryImpl.Login(event.request);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
