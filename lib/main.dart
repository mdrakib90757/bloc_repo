import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serialman_app/data/provider/auth_api.dart'; // Import your AuthApi
import 'package:serialman_app/feature/auth/bloc/auth_bloc.dart';
import 'package:serialman_app/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:serialman_app/feature/auth/screen/login_screen.dart';
import 'core/g_widgets/custom_navigationbar/custom_navigationbar.dart';
import 'feature/auth/bloc/auth_state.dart';
import 'feature/home/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthApi authApi = AuthApi();
    final AuthRepositoryImpl authRepository = AuthRepositoryImpl(authApi);

    return BlocProvider(
      create: (context) => AuthBloc(authRepository),
      child: MaterialApp(
        title: 'SerialMan App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: custom_navigationbar(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return const LoginScreen();
        } else if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthSuccess) {
          return const HomeScreen();
        } else if (state is AuthFailure) {
          return LoginScreen();
        } else {
          return const Scaffold(body: Center(child: Text("Unknown state")));
        }
      },
    );
  }
}
