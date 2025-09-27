import 'package:serialman_app/data/model/profile_modle/profile_modle.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final profile_UserModel profile;
  ProfileSuccess(this.profile);
}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure(this.message);
}
