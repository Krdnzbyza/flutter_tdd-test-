import 'dart:convert';

import 'package:flutter_test_app/home/model/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IHomeCache {
  Future<bool> saveModel(TestRestModel model);
  Future<TestRestModel?> getModel();
  Future<bool> removeModel();
  Future<TestRestModel?> getModelWithoutExpiry();

  int durationTime = 5;

  IHomeCache({int? durationTime}) {
    this.durationTime = durationTime ?? 5;
  }
}

class HomeCacheShared extends IHomeCache {
  SharedPreferences? _prefs;

  HomeCacheShared({int? time}) : super(durationTime: time);
  @override
  Future<TestRestModel?> getModel() async {
    _prefs = await SharedPreferences.getInstance();
    final _modelValues = _prefs?.getString(runtimeType.toString());
    if (_modelValues == null) return null;

    final _jsonBody = jsonDecode(_modelValues);

    return TestRestModel.fromJson(_jsonBody);
  }

  @override
  Future<bool> saveModel(TestRestModel model) async {
    _prefs = await SharedPreferences.getInstance();
    model.expiryTime = DateTime.now().add(Duration(milliseconds: durationTime)).toIso8601String();
    final _modelValues = jsonEncode(model); // stringe çevirmemize yarıyor
    return await _prefs?.setString(runtimeType.toString(), _modelValues) ?? false;
  }

  @override
  Future<bool> removeModel() async {
    _prefs = await SharedPreferences.getInstance();
    return await _prefs?.remove(runtimeType.toString()) ?? false;
  }

  @override
  Future<TestRestModel?> getModelWithoutExpiry() async {
    final data = await getModel();
    if (data != null) return data.isExpiry() ? null : data;
    return null;
  }
}
