import 'package:movie_buff/model/movie_main.dart';

class MovieMainResponse {
  late List<MovieMain> movieMainInfo;
  late String error;

  MovieMainResponse(
      this.movieMainInfo,
      this.error
      );

  MovieMainResponse.convertToMovieMainInfoResponse(Map<String, dynamic> mapObj, String errorValue, String status) {
    //final mapObj = Map<String, dynamic> ();
    if (status=="data") {
      var movieObj = mapObj["results"] as List;
      movieMainInfo = movieObj.map((m) => MovieMain.convertToMovieMainInfo(m)).toList();
      error = "";
    } else if (status=="error") {
      movieMainInfo = [];
      error = errorValue;
    }
  }
}