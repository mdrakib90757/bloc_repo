import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serialman_app/feature/auth/bloc/auth_event.dart';
import 'package:serialman_app/feature/auth/bloc/auth_state.dart';
import 'package:serialman_app/feature/auth/screen/ragistration_screen.dart';
import 'package:serialman_app/feature/home/screen/home_screen.dart';

import '../../home/screen/home_screen_2.dart';
import '../bloc/auth_bloc.dart';
import '../data/model/login_request.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController loginNameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Login Successful")));
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen2()),
              (route) => false,
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Login Failed: ${state.message}")),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                TextFormField(
                  controller: loginNameCtrl,
                  decoration: const InputDecoration(labelText: "Login Name"),
                ),
                TextFormField(
                  controller: passwordCtrl,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    final request = LoginRequest(
                      loginName: loginNameCtrl.text.trim(),
                      password: passwordCtrl.text,
                    );
                    context.read<AuthBloc>().add(LoginEvent(request));
                  },
                  child: Text("Login"),
                ),
                SizedBox(height: 20,),
                TextButton(
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                  },
                  child: const Text("Don't have an account? Register"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
