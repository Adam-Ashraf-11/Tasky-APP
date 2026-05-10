import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/core/utils/constant/app_colors.dart';
import 'package:tasky_app/core/utils/constant/constant.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/feature/user_details_view.dart';
import 'package:tasky_app/feature/welcome/presentation/views/welcome_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? userName;
  String? motivation;
  bool isDarkMode = true;
  @override
  void initState() {
    addUserName();
    super.initState();
  }

  //! add user method
  void addUserName() async {
    setState(() {
      userName = PreferencesServer().getString(cUserName) ?? '';
      motivation = PreferencesServer().getString(cMotivation) ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'My Profile'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: (8.0),
          ),
          child: Column(
            children: [
              const Gap(8),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/Thumbnail.png'),
                    radius: 60,
                    backgroundColor: Colors.transparent,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 36, 36, 36),
                      shape: BoxShape.circle,
                    ),
                    child: const IconButton(
                      onPressed: null,
                      icon: Icon(Icons.camera_alt, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const Gap(8),
              Text(
                userName ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(4),
              Text(
                motivation ?? '',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const Gap(24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Profile Info',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const Gap(24),
              ListTile(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsView(
                        motivation: motivation,
                        userName: userName,
                      ),
                    ),
                  );
                  if (result != null) {
                    addUserName();
                  }
                },
                trailing: const Icon(Icons.arrow_forward, color: Colors.white),
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.person_outlined, color: Colors.white),
                title: const Text(
                  'User Details',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              ListTile(
                trailing: Switch(
                  inactiveTrackColor: Colors.white,
                  activeTrackColor: AppColors.green,
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.dark_mode_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  'Dark Mode',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              ListTile(
                onTap: () async {
                  await PreferencesServer().remove(cUserName);
                  await PreferencesServer().remove(cMotivation);
                  await PreferencesServer().remove('tasks');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeView(),
                    ),
                    (route) => false,
                  );
                },
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.logout_outlined, color: Colors.white),
                trailing: const Icon(Icons.arrow_forward, color: Colors.white),
                title: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
