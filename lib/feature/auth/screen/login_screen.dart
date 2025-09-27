import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serialman_app/core/constansts/app_colors.dart';
import 'package:serialman_app/core/g_widgets/custom_text_field.dart';
import 'package:serialman_app/feature/auth/bloc/auth_bloc.dart';
import 'package:serialman_app/feature/auth/bloc/auth_event.dart';
import 'package:serialman_app/feature/auth/bloc/auth_state.dart';
import 'package:serialman_app/feature/auth/data/model/login_request.dart';
import 'package:serialman_app/feature/auth/screen/ragistration_screen.dart';

class LoginScreenBloc extends StatefulWidget {
  const LoginScreenBloc({super.key});

  @override
  State<LoginScreenBloc> createState() => _LoginScreenBlocState();
}

class _LoginScreenBlocState extends State<LoginScreenBloc> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController loginName = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool obscureText = true;

  @override
  void dispose() {
    loginName.dispose();
    password.dispose();
    super.dispose();
  }

  void _submitLogin(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      setState(() => autovalidateMode = AutovalidateMode.always);
      return;
    }

    final request = LoginRequest(
      loginName: loginName.text.trim(),
      password: password.text,
    );

    context.read<AuthBloc>().add(LoginEvent(request));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            // Login successful, navigate to next screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => RegistrationScreen()),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Form(
                key: _formKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/image/serialman.png",
                      height: 250,
                      width: 300,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hintText: "Login Name",
                      controller: loginName,
                      prefixIcon: Icons.person,
                      isPassword: false,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      hintText: "Password",
                      controller: password,
                      isPassword: true,
                      prefixIcon: Icons.lock,
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: isLoading ? null : () => _submitLogin(context),
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RegistrationScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
