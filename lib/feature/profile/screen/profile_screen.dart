import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serialman_app/feature/profile/bloc/profile_bloc.dart';
import 'package:serialman_app/feature/profile/bloc/profile_event.dart';
import 'package:serialman_app/feature/profile/bloc/profile_state.dart';
import 'package:serialman_app/feature/profile/data/reposiory_impl/reposiory_impl.dart';
import 'package:serialman_app/data/provider/profile_api/profile_api.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return "No DOB";
    try {
      final d = DateTime.parse(date);
      return "${d.day}-${d.month}-${d.year}";
    } catch (_) {
      return "Invalid Date";
    }
  }

  Widget _buildProfileField(String title, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(color: Colors.black, fontSize: 17),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProfileBloc(ProfileRepositoryImpl(ProfileApi()))
            ..add(fetchProfileEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Profile")),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileSuccess) {
              final profile = state.profile;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with edit button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Basic Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Navigate to edit profile screen/dialog
                          },
                          icon: Icon(
                            Icons.edit_sharp,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Profile fields
                    _buildProfileField("Name", profile.name),
                    _buildProfileField("Login Name", profile.loginName),
                    _buildProfileField("Mobile No", profile.mobileNo),
                    _buildProfileField("Email", profile.email),
                    _buildProfileField(
                      "Gender",
                      profile.profileData?.gender ?? "Not set",
                    ),
                    _buildProfileField(
                      "Date of Birth",
                      _formatDate(profile.profileData?.dateOfBirth),
                    ),
                  ],
                ),
              );
            } else if (state is ProfileFailure) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const Center(child: Text("No profile data"));
          },
        ),
      ),
    );
  }
}
