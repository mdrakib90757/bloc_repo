import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../data/model/registraotion_reqeust.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController address1lCtrl = TextEditingController();
  final TextEditingController address2Ctrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController loginNameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController conformPasswordCtrl = TextEditingController();
  final TextEditingController contactCtrl = TextEditingController();
  final TextEditingController orgCtrl = TextEditingController();

  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register Service Center")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Successful")),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Registration Failed:${state.message}")),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameCtrl,
                        decoration: const InputDecoration(labelText: "Name"),
                      ),
                      TextFormField(
                        controller: address1lCtrl,
                        decoration: const InputDecoration(
                          labelText: "addressLine1",
                        ),
                      ),
                      TextFormField(
                        controller: address2Ctrl,
                        decoration: const InputDecoration(
                          labelText: "addressLine2",
                        ),
                      ),
                      TextFormField(
                        controller: contactCtrl,
                        decoration: const InputDecoration(
                          labelText: "contactName",
                        ),
                      ),
                      TextFormField(
                        controller: emailCtrl,
                        decoration: const InputDecoration(labelText: "email"),
                      ),
                      TextFormField(
                        controller: phoneCtrl,
                        decoration: const InputDecoration(labelText: "phone"),
                      ),
                      TextFormField(
                        controller: orgCtrl,
                        decoration: const InputDecoration(
                          labelText: "organizationName",
                        ),
                      ),
                      // TextFormField(controller:, decoration: const InputDecoration(labelText: "businessTypeId")),
                      TextFormField(
                        controller: loginNameCtrl,
                        decoration: const InputDecoration(
                          labelText: "loginName",
                        ),
                      ),
                      TextFormField(
                        controller: passwordCtrl,
                        decoration: const InputDecoration(
                          labelText: "password",
                        ),
                      ),
                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          final request = RegistrationRequest(
                            name: nameCtrl.text,
                            addressLine1: address1lCtrl.text,
                            addressLine2: address2Ctrl.text,
                            contactName: contactCtrl.text,
                            email: emailCtrl.text,
                            phone: phoneCtrl.text,
                            organizationName: orgCtrl.text,
                            businessTypeId: 1,
                            loginName: loginNameCtrl.text,
                            password: passwordCtrl.text,
                          );

                          context.read<AuthBloc>().add(
                            RegistrationServiceCenterEvent(request),
                          );
                        },
                        child: const Text("Register"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
