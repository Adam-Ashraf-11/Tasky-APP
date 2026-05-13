  import 'package:flutter/material.dart';

AppBar customAppBar({Key? key, required String title , Widget? leading}) {
    return AppBar(
      elevation: 0,
      title: Text(title),
      leading: leading,
    );
  }