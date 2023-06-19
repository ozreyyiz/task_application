import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_list_app/common/app_style.dart';
import 'package:task_list_app/common/extensions/string_extension.dart';

import 'package:task_list_app/model/task.dart';
import 'package:task_list_app/service/network_service.dart';

import '../../../common/lang/locale_keys.g.dart';
import '../../projects/provider/riverpod.dart';



class TasksPage extends HookConsumerWidget {
  TasksPage({Key? key}) : super(key: key);
  // TODO: labels should be in app localization file

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkService = ref.watch(networkServiceProvider);

    return Row(
      children: [
        _taskListView(context, networkService, ref),
        SizedBox(width: 10),
        _taskDetailView(),
      ],
    );
  }

  Expanded _taskListView(
      BuildContext context, NetworkService networkService, WidgetRef ref) {
    return Expanded(
      child: Column(
        children: [
          Text(
            LocaleKeys.home_tasks.locale,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Divider(),
          SizedBox(height: 40),
          _getTasks(context, networkService, ref),
        ],
      ),
    );
  }

  FutureBuilder<List<Task>> _getTasks(
      BuildContext context, NetworkService networkService, WidgetRef ref) {
    return FutureBuilder(
        future: networkService.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error ${snapshot.error}"),
            );
          }
          if (snapshot.hasData) {
            final tasks = snapshot.data;
            if (tasks == null || tasks.isEmpty) {
              return Center(
                child: Text('No tasks available.'),
              );
            }

            return Container(
              height: 500,
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  DateTime dateTime = task.dateTime!;

                  String currentDate =
                      "${dateTime.day}/${dateTime.month}  ${dateTime.hour}:${dateTime.minute}";
                  return Card(
                    color: AppStyle.lightGrey,
                    child: ListTile(
                      title: Text(
                        task.title!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Text(
                        currentDate,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onTap: () {
                        ref.read(taskTitle.notifier).state = task.title!;
                        ref.read(taskDescription.notifier).state =
                            task.description!;
                        ref.read(taskDate.notifier).state = currentDate;
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text("Try again"),
            );
          }
        });
  }
}

Expanded _taskDetailView() {
  return Expanded(
    child: Column(
      children: [
        Consumer(
          builder: (BuildContext context, WidgetRef ref, _) {
            String title = ref.watch(taskTitle);
            String date = ref.watch(taskDate);
            String description = ref.watch(taskDescription);

            return Column(
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineMedium!
                    // .copyWith(color: AppStyle.textBlack),
                    ),
                Divider(),
                SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ],
    ),
  );
}
