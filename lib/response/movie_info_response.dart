import 'dart:ffi';

import 'package:movie_buff/model/movie_info.dart';

class MovieInfoResponse {
  late MovieInfo movieInfo;
  late String error;

  MovieInfoResponse(this.movieInfo, this.error);

  MovieInfoResponse.convertToMovieInfoResponse(Map<String, dynamic> mapObj, String errorValue, String status) {
    //final mapObj = Map<String, dynamic> ();
    if (status=="data") {
      //var movieObj = mapObj["results"] as List;
      movieInfo = MovieInfo.convertToMovieInfo(mapObj);
      error = "";
    } else if (status=="error") {
      movieInfo = MovieInfo(null, false, 0, [], [], "", 0);
      error = errorValue;
    }
  }
}