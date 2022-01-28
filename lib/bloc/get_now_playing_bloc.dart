import 'package:movie_buff/response/movie_main_response.dart';
import 'package:movie_buff/service/service_util.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingMoviesBloc {
  final ServiceUtil _serviceUtil = ServiceUtil();
  final BehaviorSubject<MovieMainResponse> _bhSubject = BehaviorSubject<MovieMainResponse>();

  getNowPlayingMovies() async {
    MovieMainResponse response = await _serviceUtil.inquireNowPlaying();
    _bhSubject.sink.add(response);
  }

  dispose() {
    _bhSubject.close();
  }

  BehaviorSubject<MovieMainResponse> get subject => _bhSubject;
  
}

final nowPlayingMoviesBloc = NowPlayingMoviesBloc();