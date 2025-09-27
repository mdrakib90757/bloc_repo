import 'package:serialman_app/data/model/business_type_model/business_type_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class BusinessTypeLoading extends AuthState {}

class BusinessTypeLoaded extends AuthState {
  final List<BusinessType> businessTypes;
  BusinessTypeLoaded(this.businessTypes);
}

class BusinessTypeError extends AuthState {
  final String message;
  BusinessTypeError(this.message);
}
