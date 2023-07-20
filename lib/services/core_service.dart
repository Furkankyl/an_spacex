import 'dart:convert';

import 'package:an_spacex/helpers/constant.dart';
import 'package:an_spacex/models/launch_data.dart';
import 'package:http/http.dart';

class CoreService{

  Future<LaunchData?> getLatestLaunchData()async{

      var url = Uri.parse(Constant.latestUrl);

      print(url);
      var response = await get(url);
      print(response);

      if(response.statusCode == 200){
        var parsedJson = json.decode(response.body);
        LaunchData launchData = LaunchData.fromJson(parsedJson);
        return launchData;
      }
      return null;
  }

  Future<List<LaunchData>?> getAllLaunchData()async{

    var url = Uri.parse(Constant.allLaunches);
    var response = await get(url);
    if(response.statusCode == 200){
      List<LaunchData> list = [];

      var parsedJson = json.decode(response.body);

      parsedJson.forEach((json){
        LaunchData launchData = LaunchData.fromJson(json);
        list.add(launchData);
      });
      return list;
    }
    return null;
  }
}