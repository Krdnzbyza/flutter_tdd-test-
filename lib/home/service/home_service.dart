import 'package:flutter_test_app/home/model/home_model.dart';
import 'package:vexana/vexana.dart';

abstract class IHomeService {
  final INetworkManager networkManager;

  Future<List<TestRestModel>?> getAllApi();

  IHomeService(this.networkManager);
}

class HomeService extends IHomeService {
  HomeService(INetworkManager networkManager) : super(networkManager);

  @override
  Future<List<TestRestModel>?> getAllApi() async {
    final response = await networkManager.send<TestRestModel, List<TestRestModel>>('/users',
        parseModel: TestRestModel(), method: RequestType.GET);
    return response.data;
  }
}
