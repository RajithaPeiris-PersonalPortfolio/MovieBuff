import 'package:movie_buff/model/movie_category.dart';

class MovieCategoryResponse {
  late List<MovieCategory> movieCategoryInfo;
  late String error;

  MovieCategoryResponse(
      this.movieCategoryInfo,
      this.error
      );

  MovieCategoryResponse.convertToCategoryInfoResponse(Map<String, dynamic> mapObj, String errorValue, String status) {
    //final mapObj = Map<String, dynamic> ();
    if (status=="data") {
      var videoObj = mapObj["genres"] as List;
      movieCategoryInfo = videoObj.map((m) => MovieCategory.convertToMovieCategoryInfo(m)).toList();
      error = "";
    } else if (status=="error") {
      movieCategoryInfo = [];
      error = errorValue;
    }
  }
}