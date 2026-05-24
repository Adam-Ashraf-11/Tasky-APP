import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/core/utils/constant/app_colors.dart';
import 'package:tasky_app/core/utils/constant/constant.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/feature/profile/presentation/manager/profile_controller.dart';
import 'package:tasky_app/feature/profile/presentation/view/user_details_view.dart';
import 'package:tasky_app/feature/profile/presentation/view/widgets/selected_image.dart';
import 'package:tasky_app/feature/welcome/presentation/views/welcome_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? userName;
  String? motivation;
  String? imagePath;
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
      imagePath = PreferencesServer().getString(cUserImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileController>(
      create: (BuildContext context) => ProfileController()..init(),
      child: Scaffold(
        appBar: customAppBar(title: 'My Profile'),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: (8.0),
            ),
            child: Column(
              children: [
               const SelectedImage(),
                const Gap(8),
                //?
                const Gap(8),
                Text(
                  userName ?? '',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Gap(4),
                //?
                Text(
                  motivation ?? '',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: ThemeController().isLight()
                        ? Colors.black87
                        : Colors.grey,
                  ),
                ),
                const Gap(24),
                //?
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Profile Info',
                    style: Theme.of(context).textTheme.labelLarge,
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
                  trailing: const Icon(Icons.arrow_forward),
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.person_outlined),
                  title: Text(
                    'User Details',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                const Divider(color: Colors.grey, thickness: 1),
                ListTile(
                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.themeNotifier,
      
                    builder: (BuildContext context, value, Widget? child) {
                      return Switch(
                        inactiveTrackColor: Colors.white,
                        activeTrackColor: AppColors.green,
                        value: value == ThemeMode.dark,
                        onChanged: (value) async {
                          ThemeController.toggleTheme();
                        },
                      );
                    },
                  ),
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.dark_mode_outlined),
                  title: Text(
                    'Dark Mode',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                const Divider(color: Colors.grey, thickness: 1),
                ListTile(
                  onTap: () async {
                    await PreferencesServer().remove(cUserName);
                    await PreferencesServer().remove(cMotivation);
                    await PreferencesServer().remove(cUserImage);
                    await PreferencesServer().remove(cTasks);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeView(),
                      ),
                      (route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.logout_outlined),
                  trailing: const Icon(Icons.arrow_forward),
                  title: Text(
                    'Log Out',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showImageSourceDialog(
    BuildContext context,
    Function(XFile) selectedFile,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsetsGeometry.all(8),
          title: const Text('Select Image '),
          children: [
            SimpleDialogOption(
              child: const Row(
                children: [
                  Icon(Icons.camera_alt_outlined),
                  Gap(8),
                  Text('Camera'),
                ],
              ),
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
            ),
            SimpleDialogOption(
              child: const Row(
                children: [Icon(Icons.photo_library), Gap(8), Text('Gallery')],
              ),
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
            ),
            // SimpleDialogOption(
            //   onPressed:() async{
            //     Navigator.pop(context);
            //     await PreferencesServer.remove(cUserImage);
            //   } ,
            //   child: Row(
            //     children: [
            //       Icon(Icons.delete, color: Colors.red),
            //       Gap(8),
            //       Text('Delete', style: TextStyle(color: Colors.red)),
            //     ],
            //   ),
            // ),
          ],
        );
      },
    );
  }

  saveImage(XFile file) async {
    final appImage = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appImage.path}/${file.name}');
    PreferencesServer().setString(cUserImage, newFile.path);
  }
}
