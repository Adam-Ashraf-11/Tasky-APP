import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/feature/profile/presentation/manager/profile_controller.dart';

class SelectedImage extends StatelessWidget {
  const SelectedImage({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (BuildContext context, controller, Widget? child) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              backgroundImage: controller.imagePath != null
                  ? FileImage(File(controller.imagePath!))
                  : const AssetImage('assets/images/Thumbnail.png'),
              radius: 60,
              backgroundColor: Colors.transparent,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: ThemeController().isLight()
                      ? Colors.grey.shade400
                      : Colors.transparent,
                  width: 2,
                ),
                color: ThemeController().isLight()
                    ? Colors.white
                    : const Color(0xff282828),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt_outlined,
                  color: ThemeController().isLight()
                      ? Colors.black87
                      : Colors.white,
                ),
                onPressed: () async {
                  controller.showImageSourceDialog(context, (XFile file) {
                    controller.saveImage(file);
                    controller.imagePath = file.path;
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
