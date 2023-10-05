import 'package:get/get.dart';
import 'package:getx_todo_list/app/data/providers/task/providers.dart';
import 'package:getx_todo_list/app/data/services/storage/repository.dart';
import 'package:getx_todo_list/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        )
    ));
  }
}