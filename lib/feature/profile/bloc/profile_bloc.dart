import 'package:bloc/bloc.dart';
import 'package:serialman_app/feature/profile/bloc/profile_event.dart';
import 'package:serialman_app/feature/profile/bloc/profile_state.dart';
import 'package:serialman_app/feature/profile/data/reposiory_impl/reposiory_impl.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositoryImpl repositoryImpl;

  ProfileBloc(this.repositoryImpl) : super(ProfileInitial()) {
    on<fetchProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profileData = await repositoryImpl.fetchProfileData();
        emit(ProfileSuccess(profileData));
      } catch (e) {
        print("Error in Bloc: $e");
        emit(ProfileFailure(e.toString()));
      }
    });
  }
}
