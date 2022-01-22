import 'package:flutter/material.dart';
import 'package:flutter_test_app/home/service/home_service.dart';
import 'package:flutter_test_app/home/viewmodel/home_viewmodel.dart';
import 'package:flutter_test_app/product/cache/home_cache.dart';
import 'package:flutter_test_app/product/cache/product_contants.dart';
import 'package:vexana/vexana.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late IHomeViewModel homeViewModel;

  @override
  void initState() {
    super.initState();
    final manager = NetworkManager(options: BaseOptions(baseUrl: ProductContants.BASE_URL));
    homeViewModel = HomeViewModel(setState, HomeCacheShared(time: 100000), HomeService(manager), showScaffoldMessage);
    homeViewModel.fetchAllDatas();
  }

  void showScaffoldMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('test ok')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeViewModel.backgroundColor,
      appBar: AppBar(title: Text('${homeViewModel.title ?? ''}')),
      body: homeViewModel.isLoading ? _circularProgress() : _buildListProfile(),
    );
  }

  Widget _circularProgress() => Center(child: CircularProgressIndicator.adaptive());

  ListView _buildListProfile() {
    return ListView.builder(
      itemCount: homeViewModel.testReqModel.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            homeViewModel.cacheItItems(homeViewModel.testReqModel[index]);
          },
          leading: CircleAvatar(
            child: Text(homeViewModel.testReqModel[index].id.toString()),
          ),
          title: Text(homeViewModel.testReqModel[index].name ?? ''),
        );
      },
    );
  }
}
