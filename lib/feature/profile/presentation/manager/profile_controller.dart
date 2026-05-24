import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/core/utils/constant/constant.dart';

class ProfileController extends ChangeNotifier {
  String? userName;
  String? motivation;
  String? imagePath;


  void init(){
  addUserName();
  notifyListeners();

  }

  //! add user method
  void addUserName() async {
    userName = PreferencesServer().getString(cUserName) ?? '';
    motivation = PreferencesServer().getString(cMotivation) ?? '';
    imagePath = PreferencesServer().getString(cUserImage);
    notifyListeners();
  }

  saveImage(XFile file) async {
    final appImage = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appImage.path}/${file.name}');
    PreferencesServer().setString(cUserImage, newFile.path);
    notifyListeners();
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

}
