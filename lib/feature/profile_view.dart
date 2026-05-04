import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'My Profile'),
      body: const Center(
        child:Column(
          children: [
            Gap(8),
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/Thumbnail.png'),
                  radius: 60,
                  backgroundColor: Colors.transparent,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: null,
                    icon:Icon(Icons.camera_alt, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
