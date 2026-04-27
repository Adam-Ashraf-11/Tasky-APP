import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tasky_app/core/widgets/custom_eleveted_button.dart';
import 'package:tasky_app/core/widgets/custom_text_feild.dart';

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Gap(20),

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

          const Gap(28),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Full Name',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const Gap(16),
          const CustomTextFeild(hint: 'e.g. Sarah Khalid'),

          const Gap(24),
          CustomElevetedButton(
            title: 'Let’s Get Started',
            w: MediaQuery.sizeOf(context).width, onPressed: () {  },
          ),
        ],
      ),
    );
  }
}
