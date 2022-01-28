import 'package:movie_buff/model/movie_category.dart';
import 'package:movie_buff/model/owner.dart';

class MovieInfo {
  int? id;
  late bool hasAdultContent;
  late int budget;
  late List<MovieCategory> movieCategory;
  late List<Owner> owner;
  late String releaseDate;
  late int movieRuntime;

  MovieInfo(
      this.id, this.hasAdultContent, this.budget, this.movieCategory,
      this.owner, this.releaseDate, this.movieRuntime
      );

  MovieInfo.convertToMovieInfo(Map<String, dynamic> mapObj) {
   //if(id!=null) {
    id = mapObj['id'];
    //}

    hasAdultContent = mapObj['adult'];
    budget = mapObj['budget'];

    var categotyList = mapObj['genres'] as List;
    movieCategory = categotyList.map((e) => MovieCategory.convertToMovieCategoryInfo(e)).toList();

    var companyList = mapObj['production_companies'] as List;
    owner = companyList.map((e) => Owner.convertToOwnerInfo(e)).toList();

    releaseDate = mapObj['release_date'];
    movieRuntime = mapObj['runtime'];
    //return mapObj;
  }
}