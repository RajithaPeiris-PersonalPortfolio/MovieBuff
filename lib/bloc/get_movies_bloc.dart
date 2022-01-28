
import 'package:movie_buff/response/movie_main_response.dart';
import 'package:movie_buff/service/service_util.dart';
import 'package:rxdart/rxdart.dart';

class MoviesAllBloc {
  final ServiceUtil _serviceUtil = ServiceUtil();
  final BehaviorSubject<MovieMainResponse> _bhSubject = BehaviorSubject<MovieMainResponse>();

  getMovies() async {
    MovieMainResponse response = await _serviceUtil.inquireAllMovies();
    _bhSubject.sink.add(response);
  }

  dispose() {
    _bhSubject.close();
  }

  BehaviorSubject<MovieMainResponse> get subject => _bhSubject;
  
}
final moviesAllBloc = MoviesAllBloc();