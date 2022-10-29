import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jakes_git_task/home_controller.dart';

class HomeView extends GetView<HomeController> {
  static String routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: controller.getAllData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (controller.data.contains('empty')) {
                return const Text('No Data');
              } else {
                return ListView.separated(
                  padding: const EdgeInsets.all(10),
                  controller: controller.scrollController,
                  itemCount: controller.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = controller.data[index];
                    if (index < controller.data.length - 1) {
                      return ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: const Icon(
                            Icons.book_rounded,
                            size: 70,
                          ),
                          title: Text(
                            '${item['name']} ',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          subtitle: Flexible(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${item['description']?.replaceAll("[DEPRECATED]", "")} ',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  Row(
                                    children: [
                                      const Text('< > ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Text('${item['language']} '),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(Icons.woman),
                                      Text('${item['forks']}'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(Icons.face_outlined,
                                          color: Colors.black, size: 20),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text('${item['watchers_count']}')
                                    ],
                                  )
                                ]),
                          )
                          //Text(item['name']),
                          );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(color: Colors.black);
                  },
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
