import 'package:movie_buff/model/video.dart';

class VideoInfoResponse {
  late List<VideoInfo> videoInfo;
  late String error;

  VideoInfoResponse(
    this.videoInfo,
    this.error
  );

  VideoInfoResponse.convertToVideoInfoResponse(Map<String, dynamic> mapObj, String errorValue, String status) {
    //final mapObj = Map<String, dynamic> ();
    if (status=="data") {
      var videoObj = mapObj["results"] as List;
      videoInfo = videoObj.map((m) => VideoInfo.convertToVideoInfo(m)).toList();
      error = "";
    } else if (status=="error") {
      videoInfo = [];
      error = errorValue;
    }

  }
}