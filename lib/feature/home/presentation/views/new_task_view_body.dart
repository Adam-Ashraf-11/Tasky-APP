import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/widgets/custom_eleveted_button.dart';
import 'package:tasky_app/core/widgets/custom_text_form_feild.dart';
import 'package:tasky_app/feature/home/presentation/manager/add_new_task_controller.dart';

class NewTaskViewBody extends StatelessWidget {
  const NewTaskViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddNewTaskController>(
      create: (BuildContext context) => AddNewTaskController(),
      builder: (BuildContext context, _) {
        final controller = context.read<AddNewTaskController>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task Name',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const Gap(8),
                        CustomTextFormFeild(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please Enter Task Name';
                            }
                            return null;
                          },
                          hint: 'Enter Task Name',
                          controller: controller.taskNameController,
                        ),
                        const Gap(20),
                        Text(
                          'Task Description',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const Gap(8),
                        CustomTextFormFeild(
                          hint: 'Enter Task Description',
                          controller: controller.taskDescreptionController,
                          maxLines: 6,
                        ),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'High Priority  ',
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Consumer<AddNewTaskController>(
                              builder: (context, value, child) {
                                return Switch(
                                  value: value.isHighPriority,
                                  onChanged: (bool value) {
                                    controller.toogle(value);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CustomElevetedButton(
                  title: 'Add Task',
                  onPressed: () async {
                    controller.addNewTask(context);
                  },
                ),
                const Gap(40),
              ],
            ),
          ),
        );
      },
    );
  }
}
