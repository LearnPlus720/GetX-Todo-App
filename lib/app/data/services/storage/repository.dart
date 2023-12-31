import 'package:getx_todo_list/app/data/providers/task/providers.dart';

import 'package:getx_todo_list/app/data/models/task.dart';

class TaskRepository{
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});
  List<Task> readTasks() => taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}