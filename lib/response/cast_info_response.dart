import 'package:movie_buff/model/cast_info.dart';

class CastInfoResponse {
  late List<CastInfo> castInfo;
  late String error;

  CastInfoResponse(
      this.castInfo,
      this.error
      );

  CastInfoResponse.convertToCastInfoResponse(Map<String, dynamic> mapObj, String errorValue, String status) {
    //final mapObj = Map<String, dynamic> ();
    if (status=="data") {
      var castObj = mapObj["cast"] as List;
      castInfo = castObj.map((m) => CastInfo.convertToCastInfo(m)).toList();
      error = "";
    } else if (status=="error") {
      castInfo = [];
      error = errorValue;
    }

    //castInfo = (mapObj["cast"] as List).map((i) => CastInfo.convertToCastInfo(i).cast<CastInfo>().toList(),
    //(mapObj['cast'] as List).map((e) => new CastInfo.convertToCastInfo(e)).toList(),
    //mapObj['name'] = name;
    //mapObj['profile_path'] = profileImage;

    //return mapObj;
  }
}