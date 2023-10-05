import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_list/app/core/utils/extensions.dart';
import 'package:getx_todo_list/app/modules/home/controller.dart';

class ReportPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx((){
          var createdTasks = homeCtrl.getTotalTask();
          var completedTasks = homeCtrl.getTotalDoneTask();
          var liveTasks = createdTasks - completedTasks;
          var percent = ( completedTasks /createdTasks * 100);
          return ListView(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(4.0.wp),
                    child: Text("My Report",
                      style: TextStyle(
                        fontSize: 24.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
          );


        }),
      ),
    );
  }
}
