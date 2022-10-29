import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jakes_git_task/apppages.dart';
import 'package:jakes_git_task/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Jake\'s Git',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomeView.routeName,
      getPages: pages,
    );
  }
}
