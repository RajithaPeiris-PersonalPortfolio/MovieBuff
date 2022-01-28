import 'package:movie_buff/model/trending_person.dart';

class TrendingPersonResponse {
  late List<TrendingPerson> tpInfo;
  late String error;

  TrendingPersonResponse(
      this.tpInfo,
      this.error
      );

  TrendingPersonResponse.convertToTrendingPersonInfoResponse(Map<String, dynamic> mapObj, String errorValue, String status) {
    //final mapObj = Map<String, dynamic> ();
    if (status=="data") {
      var videoObj = mapObj["results"] as List;
      tpInfo = videoObj.map((m) => TrendingPerson.convertToTrendingPersonInfo(m)).toList();
      error = "";
    } else if (status=="error") {
      tpInfo = [];
      error = errorValue;
    }

  }
}