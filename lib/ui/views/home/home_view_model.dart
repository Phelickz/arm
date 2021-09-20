import 'package:arm_test/app/core/custom_base_view_model.dart';
import 'package:arm_test/app/locator/locator.dart';
import 'package:arm_test/app/models/news.dart';
import 'package:arm_test/app/services/router_service.dart';
import 'package:arm_test/app/services/snackBar.dart';
import 'package:arm_test/app/utils/constants.dart';
import 'package:dio/dio.dart';

class HomeViewModel extends CustomBaseViewModel {
  final RouterService _routerService = locator<RouterService>();

  Future navigateTo(dynamic object) async {
    await _routerService.router.push(
      object
    );
  }
  Future<void> init() async {
    await getNews();
  }

  News? _news;
  News? get news => _news;


  Future<void> getNews() async {
    try {
      setBusy(true);
      DateTime current = DateTime.now();
      String thisInstance = '${current.year}-${current.month}-${current.day}';
      Response response = await dio.get('/top-headlines', queryParameters: {
        "sources": "bbc-news",
        "from": thisInstance,
        "sortBy": 'popularity',
        "apiKey": Constants.NEWS_API_KEY
      });

      if(response.statusCode.toString().startsWith('2')) {
        News news = News.fromJson(response.data);
        _news = news;
        notifyListeners();
        setBusy(false);
        print(_news!.articles!.length);
      }
      setBusy(false);
    } on DioError catch (e) {
      SnackBarAlerts.showToast(e.message);
      setBusy(false);
    }
  }
}
