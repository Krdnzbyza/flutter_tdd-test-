import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/home/model/home_model.dart';
import 'package:flutter_test_app/home/service/home_service.dart';
import 'package:flutter_test_app/product/cache/home_cache.dart';

// ignore: prefer_generic_function_type_aliases
typedef void UIUpdate(VoidCallback fn);
// ignore: prefer_generic_function_type_aliases

typedef void SnackBarShow();

abstract class IHomeViewModel {
  final UIUpdate viewUpdate;
  final SnackBarShow snackBarShow;

  Color? backgroundColor = Colors.white;
  List<TestRestModel> testReqModel = [];

  bool isLoading = true;
  void changeColor(Color color);
  void changeLoading();
  void fetchAllDatas();
  void initCacheDatas();
  Future<void> cacheItItems(TestRestModel profile);

  IHomeService homeService;
  IHomeCache homeCache;
  String? title;
  IHomeViewModel(this.viewUpdate, this.homeCache, this.homeService, this.snackBarShow);
}

class HomeViewModel extends IHomeViewModel {
  HomeViewModel(UIUpdate viewUpdate, IHomeCache homeCache, IHomeService homeService, SnackBarShow snackBarShow)
      : super(viewUpdate, homeCache, homeService, snackBarShow) {
    initCacheDatas();
  }

  @override
  void changeColor(Color color) {
    backgroundColor = color;

    viewUpdate(() {});
  }

  @override
  void changeLoading() {
    isLoading = !isLoading;
    viewUpdate(() {});
  }

  @override
  Future<void> fetchAllDatas() async {
    final data = await homeService.getAllApi();
    if (data != null) testReqModel = data;
    changeLoading();
  }

  @override
  Future<void> initCacheDatas() async {
    final data = await homeCache.getModelWithoutExpiry();

    if (data != null) {
      title = '${data.name}-${data.username}';
      viewUpdate(() {});
    }
  }

  @override
  Future<void> cacheItItems(TestRestModel profile) async {
    if (await homeCache.saveModel(profile)) {
      title = profile.name;
      snackBarShow();
      viewUpdate(() {});
    }
  }
}
