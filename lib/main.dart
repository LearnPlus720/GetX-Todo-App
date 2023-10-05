import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getx_todo_list/app/modules/home/bindings.dart';

import 'app/data/services/storage/services.dart';
import 'app/modules/home/view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


void main() async{
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo List GetX',
      home: const HomePage(),
      initialBinding: HomeBinding(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}

