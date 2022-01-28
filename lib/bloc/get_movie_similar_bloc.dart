import 'package:flutter/material.dart';
import 'package:movie_buff/response/movie_main_response.dart';
import 'package:movie_buff/service/service_util.dart';
import 'package:rxdart/rxdart.dart';

class SimilarMoviesBloc {
  final ServiceUtil _serviceUtil = ServiceUtil();
  final BehaviorSubject<MovieMainResponse> _bhSubject = BehaviorSubject<MovieMainResponse>();

  getSimilarMovies(int movieId) async {
    MovieMainResponse response = await _serviceUtil.inquireSimilarMovies(movieId);
    _bhSubject.sink.add(response);
  }

  void drainStream() async {
    await _bhSubject.drain();
  }

  @mustCallSuper
  void dispose() async {
    await _bhSubject.drain();
    _bhSubject.close();
  }

  BehaviorSubject<MovieMainResponse> get subject => _bhSubject;
}

final similarMoviesBloc = SimilarMoviesBloc();
