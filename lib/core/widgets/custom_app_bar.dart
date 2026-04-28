  import 'package:flutter/material.dart';

AppBar customAppBar({Key? key, required String title}) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.white,
      title: Text(title),
    );
  }