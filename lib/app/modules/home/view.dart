import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';
import 'package:getx_todo_list/app/modules/home/controller.dart';
import 'package:getx_todo_list/app/modules/home/widgets/add_card.dart';
import 'package:getx_todo_list/app/modules/home/widgets/add_dialog.dart';
import 'package:getx_todo_list/app/modules/home/widgets/task_card.dart';

import '../../data/models/task.dart';
import '../report/view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            ()=> IndexedStack(
          index: controller.tabIndex.value,
          children:[
            SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding:  EdgeInsets.all(4.0.wp),
                  child: Text('My List',
                    style: TextStyle(
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ),
                Obx(() =>
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    // TaskCard(
                    //     task :Task(
                    //       title: 'title', icon: 0xe59c , color: '#FF2B60E6',
                    //     )),
                    ...controller.tasks.map((element) =>
                        LongPressDraggable(
                            data: element,
                            onDragStarted: ()=> controller.changeDeleting(true),
                            onDraggableCanceled: (_, __)=> controller.changeDeleting(false),
                            onDragEnd: (_)=> controller.changeDeleting(false),
                            feedback: Opacity(
                              opacity: 0.8,
                              child: TaskCard(task: element,),
                            ),
                            child: TaskCard(task: element,)
                        )
                    ).toList(),
                    AddCard()
                  ],


                    )
                ),
              ],
            ),
          ),
            ReportPage(),
          ]
        ),
      ),
      floatingActionButton: DragTarget(
        builder: (_, __ , ___) {
          return Obx(
                () =>
                FloatingActionButton(
                  backgroundColor: controller.deleting.value
                      ? Colors.red
                      : Colors.blue,
                  onPressed: () {
                    if(controller.tasks.isNotEmpty){
                      Get.to(()=> AddDialog(), transition: Transition.downToUp);
                    }else{
                      EasyLoading.showInfo("Pleas create your task type first");
                    }
                  },
                  child: Icon(
                    controller.deleting.value ? Icons.delete : Icons.add,

                  ),
                ),
          );

        },
        onAccept: (Task task){
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Success');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent
        ),
        child: Obx(
          ()=> BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex:  controller.tabIndex.value,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: Padding(
                    padding: EdgeInsets.only(right: 15.0.wp),
                    child: const Icon(Icons.apps),
                  )
              ),

              BottomNavigationBarItem(
                  label: 'Report',
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15.0.wp),
                    child: const Icon(Icons.data_usage),
                  )
              ),
            ],
          ),
        ),
      ),

    );
  }
}