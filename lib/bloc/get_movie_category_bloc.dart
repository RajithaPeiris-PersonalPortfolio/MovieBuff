import 'package:movie_buff/response/movie_category_response.dart';
import 'package:movie_buff/service/service_util.dart';
import 'package:rxdart/rxdart.dart';

class MovieCategoryListBloc {
  final ServiceUtil _serviceUtil = ServiceUtil();
  final BehaviorSubject<MovieCategoryResponse> _bhSubject = BehaviorSubject<MovieCategoryResponse>();

  getAllMovieCategory() async {
    MovieCategoryResponse response = await _serviceUtil.inquireMovieCategoryList();
    _bhSubject.sink.add(response);
  }

  dispose() {
    _bhSubject.close();
  }

  BehaviorSubject<MovieCategoryResponse> get subject => _bhSubject;
  
}

final categoryBloc = MovieCategoryListBloc();