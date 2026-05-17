import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasky_app/feature/welcome/presentation/views/components/welcome_bottom_components.dart';
import 'package:tasky_app/feature/welcome/presentation/views/components/welcome_top_components.dart';

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Gap(20),
            const WelcomeTopSection(),
            const Gap(28),
            WelcomeBottomSection(),
          ],
        ),
      ),
    );
  }
}
