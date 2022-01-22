import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/home/model/home_model.dart';
import 'package:flutter_test_app/product/cache/home_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late IHomeCache homeCache;
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    homeCache = HomeCacheShared(time: 10);
  });
  test('Cache It Sample', () async {
    final model = TestRestModel(email: 'byza@gmail.com', name: 'v', username: 'tinkybk');
    final result = await homeCache.saveModel(model);
    expect(result, isTrue);
  });

  test('Cache It Get', () async {
    final model = TestRestModel(email: 'byza@gmail.com', name: 'v', username: 'tinkybk');
    final _ = await homeCache.saveModel(model);
    final modelCache = await homeCache.getModel();
    expect(modelCache == model, isTrue);
  });

  test('Cache It With Expiry True', () async {
    final model = TestRestModel(email: 'byza@gmail.com', name: 'v', username: 'tinkybk');
    final _ = await homeCache.saveModel(model);
    final modelCache = await homeCache.getModelWithoutExpiry();
    expect(modelCache == model, isTrue);
  });
  test('Cache It With Expiry False', () async {
    final model = TestRestModel(email: 'byza@gmail.com', name: 'v', username: 'tinkybk');
    final _ = await homeCache.saveModel(model);
    await Future.delayed(const Duration(milliseconds: 11));
    final modelCache = await homeCache.getModelWithoutExpiry();
    expect(modelCache == null, isTrue);
  });
}
