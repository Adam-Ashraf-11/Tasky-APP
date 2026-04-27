import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasky_app/feature/welcome/presentation/views/widgets/welcome_bottom_section.dart';
import 'package:tasky_app/feature/welcome/presentation/views/widgets/welcome_top_section.dart';

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
