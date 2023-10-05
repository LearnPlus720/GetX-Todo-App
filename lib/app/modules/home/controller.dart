
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/data/services/storage/repository.dart';

import '../../data/models/task.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});
  final formKey= GlobalKey<FormState>();
  final editController =  TextEditingController();
  final tabIndex =0.obs;
  final chipIndex = 0.obs;
  final  deleting = false.obs;
  final tasks = <Task>[].obs;
  final doingTodos =<dynamic>[].obs;
  final doneTodos =<dynamic>[].obs;

  // for add dialog
  final task =Rx<Task?>(null);

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    print("tasks length is ${tasks.length}");
    ever(tasks, (_) => taskRepository.writeTasks(tasks));

  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }


  void changeChipIndex(int value){
    chipIndex.value = value;
  }
  void changeDeleting(bool value){
    deleting.value = value;
    print("changeDeleting to $value");
  }
  
  bool addTask(Task task){
    print("add task");
    if(tasks.contains(task)){
      return false;
    }
    tasks.add(task);

    return true;
  }
  void deleteTask(Task task){
    tasks.remove(task);
  }

  void changeTask(Task? select ){
    task.value = select;
  }

  void changeTodos(List<dynamic> select){
    doingTodos.clear();
    doneTodos.clear();
    for ( int i= 0 ; i < select.length ; i++){
        var todo = select[i];
        var status = todo['done'];
        if(status == true ){
          doneTodos.add(todo);
        }else{
          doingTodos.add(todo);
        }
    }
  }
  updateTask(Task task,String title){
    var todos = task.todos ?? [];
    if(containeTodo(todos, title)){
        return false;
    }
    var todo ={'title' : title , 'done' : false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldTask = tasks.indexOf(task);
    tasks[oldTask] = newTask;
    tasks.refresh();
    return true;
  }

  bool addTodo(String title){
    var todo ={'title' : title , 'done' : false};
    if(doingTodos.any((element) => mapEquals<String, dynamic> (todo, element))){
      return false;
    }
    var doneTodo = {'title' : title , 'done' : true};
    if(doneTodos.any((element) => mapEquals<String, dynamic> (doneTodo, element))){
      return false;
    }

    doingTodos.add(todo);
    return true;


    
  }
  void updateTodos(){
    var newTodos = <Map<String,dynamic>>[];
    newTodos.addAll([
      ...doingTodos,
      ...doneTodos,
    ]);
    print("newTodos $newTodos");

    var newTask = task.value!.copyWith(todos: newTodos);

    int oldTask = tasks.indexOf(task.value);

    tasks[oldTask] = newTask;
    tasks.refresh();

  }

  doneTodo(String title){
    var doingTodo = {'title' : title , 'done' : false};
    int index = doingTodos.indexWhere((element) =>  mapEquals<String, dynamic> (doingTodo, element));
    doingTodos.removeAt(index);
    var doneTodo = {'title' : title , 'done' : true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();

  }
  deleteDoneTodo(dynamic doneTodo){
    int index = doneTodos.indexWhere((element) =>  mapEquals<String, dynamic> (doneTodo, element));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }
  bool containeTodo(List todos,String title){

    return todos.any((element) => element['title'] == title);
  }

  bool isTodoEmpty(Task task){
    return task.todos == null || task.todos!.isEmpty;
  }

  int getDoneTodo(Task task){
    var res = 0;
    for ( int i= 0 ; i < task.todos!.length ; i++){

      var status = task.todos![i]['done'];
      if(status == true ){
        res +=1;
      }

    }
    return res;
  }

  void changeTabIndex(int index){
    tabIndex.value = index;
  }

  int getTotalTask(){
    var res = 0;
    for ( int i= 0 ; i < tasks.length ; i++){
        if(tasks[i].todos != null){
          res += tasks[i].todos!.length ;
        }
    }
    return res;
  }

  int getTotalDoneTask(){
    var res = 0;
    for ( int i= 0 ; i < tasks.length ; i++){
      if(tasks[i].todos != null){
        res +=  getDoneTodo(tasks[i]);
      }
    }
    return res;
  }

  
}