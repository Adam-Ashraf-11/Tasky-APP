import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasky_app/core/services/Preferences_server.dart';
import 'package:tasky_app/core/utils/constant/constant.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/core/widgets/custom_eleveted_button.dart';
import 'package:tasky_app/core/widgets/custom_text_form_feild.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({super.key,  this.userName,  this.motivation});
  static const routeName = 'user-details';
  final String? userName ;
  final String? motivation ;

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController motivationController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override

  void initState() {
    userNameController.text = widget.userName ?? '';
    motivationController.text = widget.motivation ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'User Details'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
               Text(
                'User Name',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Gap(20),

              CustomTextFormFeild(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please Enter User Name';
                  }
                  return null;
                },
                hint: widget.userName ?? 'Enter User Name',
                controller: userNameController,
              ),
              const Gap(20),
               Text(
                'Motivation Quote',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Gap(20),
              CustomTextFormFeild(
                hint: widget.motivation ?? 'Enter Motivation Quote',
                controller: motivationController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please Enter Motivation Quote';
                  }
                  return null;
                },
                maxLines: 6,
              ),
              const Spacer(),
              Center(
                child: CustomElevetedButton(
                  title: 'Save Changes',
                  onPressed: () async {
                    if (formKey.currentState!.validate())  {
                    await PreferencesServer().setString(cUserName, userNameController.text);
                    await PreferencesServer().setString(cMotivation, motivationController.text);
                    Navigator.pop(context, true);
                    }
                  },
                ),
              ),
              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}
