import 'dart:developer';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class HomeController extends GetxController {
  RxBool isloading = false.obs;
  RxBool hasMore = false.obs;
  Box? box;
  List data = [].obs;

  List post = [].obs;
  late ScrollController scrollController;
  int page = 1;

  @override
  void onInit() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    getAllData();
    super.onInit();
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      isloading.value = true;
      log('call');
      page++;
      await getAllData(page);
      isloading.value = false;
    } else {
      log('don\'t call');
    }
  }

  Future onrefresh() async {
    isloading.value = false;
    hasMore.value = true;
    page = 0;
    post.clear();
  }

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('data');
    return;
  }

  Future<bool> getAllData([pagenumber = 1]) async {
    await openBox();
    try {
      final url =
          'https://api.github.com/users/JakeWharton/repos?page=$pagenumber&per_page=15';
      final response = await http.get(
        Uri.parse(url),
      );

      log('url:--> $url');
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        //post = json;
        await putData(json);
        log(json.toString());
        //  return json;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (SocketException) {
      log('No Internet');
    }
    var mymap = box?.toMap().values.toList();

    if (mymap!.isEmpty) {
      data.add('empty');
    } else {
      data = data + mymap;
    }
    return Future.value(true);
  }

  Future putData(data) async {
    // await box?.clear();
    for (var d in data) {
      box?.add(d);
    }
  }
}
