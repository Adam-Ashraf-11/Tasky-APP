import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasky_app/core/widgets/custom_eleveted_button.dart';
import 'package:tasky_app/core/widgets/custom_text_form_feild.dart';
import 'package:tasky_app/feature/home/presentation/views/home_view.dart';

class WelcomeBottomSection extends StatelessWidget {
 WelcomeBottomSection({super.key});
  
 final TextEditingController controller = TextEditingController();
 final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Full Name',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const Gap(16),
           CustomTextFormFeild(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your Full Name';
              }
              return null;
            },
            hint: 'e.g. Sarah Khalid' ,controller: controller ,),
          const Gap(24),
          CustomElevetedButton(
            
            title: 'Let’s Get Started',
            w: MediaQuery.sizeOf(context).width,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                controller.clear();
                 Navigator.pushNamed(context, HomeView.routeName);
              }
             
            },
          ),
        ],
      ),
    );
  }
}
