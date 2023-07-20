import 'dart:convert';

import 'package:an_spacex/helpers/constant.dart';
import 'package:an_spacex/models/launch_data.dart';
import 'package:http/http.dart';

class CoreService {
  static Future<LaunchData?> getLatestLaunchData() async {
    var url = Uri.parse(Constant.latestUrl);

    var response = await get(url);

    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      LaunchData launchData = LaunchData.fromJson(parsedJson);
      return launchData;
    }
    return null;
  }

  ///VERİYİ SAYIYA GÖRE ÇEKMEK İÇİN `Api-Key` GEREKEKİYOR
  ///`SpaceX API Docs` [https://documenter.getpostman.com/view/2025350/RWaEzAiG]
  ///O YÜZDEN [dataCount] TANIMLAYIP SAYIYI ARTIRARAK FAKE LOADING YAPILDI
  static Future<List<LaunchData>?> getAllLaunchData(int dataCount) async {
    var url = Uri.parse(Constant.allLaunches);
    var response = await get(url);
    if (response.statusCode == 200) {
      List<LaunchData> list = [];

      var parsedJson = json.decode(response.body);

      parsedJson.forEach((json) {
        LaunchData launchData = LaunchData.fromJson(json);
        list.add(launchData);
      });

      list.sort((b, a) => a.flightNumber!.compareTo(b.flightNumber!));
      return list.sublist(0,dataCount);
    }
    return null;
  }
}
