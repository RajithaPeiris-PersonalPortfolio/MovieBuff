import 'package:flutter/material.dart';
import 'package:movie_buff/response/movie_info_response.dart';
import 'package:movie_buff/service/service_util.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc {
  final ServiceUtil _serviceUtil = ServiceUtil();
  final BehaviorSubject<MovieInfoResponse> _bhSubject = BehaviorSubject<MovieInfoResponse>();


  getMovieInfoById(int movieId) async {
    MovieInfoResponse response = await _serviceUtil.inquireMovieInfoById(movieId);
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

  BehaviorSubject<MovieInfoResponse> get subject => _bhSubject;
}

final movieDetailBloc = MovieDetailBloc();
