import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WelcomeTopSection extends StatelessWidget {
  const WelcomeTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
                  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/app_logo.svg',
                  height: 42,
                  width: 42,
                ),
                const Gap(16),
                const Text(
                  'Tasky',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Gap(108),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(20),
                const Text(
                  'Welcome to Tasky',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(8),
                SvgPicture.asset(
                  'assets/images/waving_hand.svg',
                  height: 28,
                  width: 28,
                ),
              ],
            ),
            const Gap(10),
            const Text(
              'Your productivity journey starts here.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Gap(24),
            SvgPicture.asset(
              'assets/images/welcome_icon.svg',
              height: 204,
              width: 215,
            ),
    ]);
  }
}