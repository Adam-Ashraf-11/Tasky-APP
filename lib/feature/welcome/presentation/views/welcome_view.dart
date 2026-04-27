import 'package:flutter/material.dart';

import 'package:tasky_app/feature/welcome/presentation/views/welcome_view_body.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});
 
  static const routeName = 'welcomeView';
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff181818),
        body: WelcomeViewBody()
      ),
    );
  }
}
