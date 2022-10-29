import 'package:get/get.dart';
import 'package:jakes_git_task/home_view.dart';

import 'home_controller.dart';

List<GetPage> pages = [
  GetPage(
    name: HomeView.routeName,
    page: () => HomeView(),
    binding: BindingsBuilder(
      () => Get.lazyPut<HomeController>(() => HomeController()),
    ),
  ),
];
