import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/home/model/home_model.dart';
import 'package:flutter_test_app/home/service/home_service.dart';
import 'package:vexana/vexana.dart';

void main() {
  late INetworkManager networkManager;
  late IHomeService homeService;

  setUp(() {
    networkManager = NetworkManager(options: BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
    homeService = HomeService(networkManager);
  });
  test('Home Service Test', () async {
    final response = await networkManager.send<TestRestModel, List<TestRestModel>>('/users',
        parseModel: TestRestModel(), method: RequestType.GET);

    expect(response, isNotNull);
    expect(response.data, isNotNull);
  });

  test('Home Service Test', () async {
    final response = await homeService.getAllApi();

    expect(response, isNotNull);
  });
}
