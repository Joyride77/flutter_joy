import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_firebase/constants/app_style.dart';
import 'package:todo_firebase/model/todo_model.dart';
import 'package:todo_firebase/provider/date_time_provider.dart';
import 'package:todo_firebase/provider/radio_provider.dart';
import 'package:todo_firebase/provider/service_provider.dart';
import 'package:todo_firebase/widget/date_time_button_widget.dart';
import 'package:todo_firebase/widget/date_time_widget.dart';
import 'package:todo_firebase/widget/radio_widget.dart';
import 'package:todo_firebase/widget/textfield_widget.dart';

class AddNewTaskModel extends ConsumerWidget {
  AddNewTaskModel({
    super.key,
  });

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
              width: double.infinity,
              child: Text(
                "New Task Todo",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
              )),
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),
          const Gap(12),
          const Text('Title Task', style: AppStyle.headingOne),
          const Gap(6),
          TextFieldWidget(
            hintText: 'Add Task Name',
            maxLine: 1,
            txtController: titleController,
          ),
          const Gap(12),
          const Text('Description', style: AppStyle.headingOne),
          const Gap(6),
          TextFieldWidget(
            hintText: 'Add Description',
            maxLine: 3,
            txtController: descriptionController,
          ),
          const Gap(12),
          const Text('Category', style: AppStyle.headingOne),
          Row(
            children: [
              Expanded(
                child: RadioWidget(
                  titleRadio: 'Learning',
                  categColor: Colors.green,
                  valueInput: 1,
                  onChangeValue: () => ref.read(radioProvider.notifier).update((state) => 1),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: 'Working',
                  categColor: Colors.blue.shade700,
                  valueInput: 2,
                  onChangeValue: () => ref.read(radioProvider.notifier).update((state) => 2),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: 'General',
                  categColor: Colors.amberAccent.shade700,
                  valueInput: 3,
                  onChangeValue: () => ref.read(radioProvider.notifier).update((state) => 3),
                ),
              ),
            ],
          ),

          // Date and Time Section

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeWidget(
                titleText: 'Date',
                valueText: dateProv,
                iconSection: CupertinoIcons.calendar,
                onTap: () async {
                  final getValue = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2025),
                  );
                  if (getValue != null) {
                    final format = DateFormat.yMd();
                    ref.read(dateProvider.notifier).update((state) => format.format(getValue));
                  }
                },
              ),
              const Gap(22),
              DateTimeWidget(
                titleText: 'Time',
                valueText: ref.watch(timeProvider),
                iconSection: CupertinoIcons.clock,
                onTap: () async {
                  final getTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (getTime != null) {
                    ref.read(timeProvider.notifier).update((state) => getTime.format(context));
                  }
                },
              ),
            ],
          ),

          //Button Section

          const Gap(12),
          Row(
            children: [
              DateTimeButton(
                bgColor: Colors.white,
                textColor: Colors.blue.shade800,
                btnText: 'Cancel',
                onPressed: () => Navigator.pop(context),
              ),
              const Gap(20),
              DateTimeButton(
                bgColor: Colors.blue.shade800,
                textColor: Colors.white,
                btnText: 'Create',
                onPressed: () {
                  final getRadioValue = ref.read(radioProvider);
                  String category = '';

                  switch (getRadioValue) {
                    case 1:
                      category = 'Learning';
                      break;
                    case 2:
                      category = 'Working';
                      break;
                    case 3:
                      category = 'General';
                      break;
                  }

                  ref.read(serviceProvider).addNewTask(TodoModel(
                        titleTask: titleController.text,
                        description: descriptionController.text,
                        category: category,
                        dateTask: ref.read(dateProvider),
                        timeTask: ref.read(timeProvider),
                        isDone: false,
                      ));
                  print("data is saving");

                  titleController.clear();
                  descriptionController.clear();
                  ref.read(radioProvider.notifier).update((state) => 0);
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
