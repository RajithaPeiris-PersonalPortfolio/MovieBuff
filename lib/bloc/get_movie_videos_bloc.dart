import 'package:flutter/material.dart';
import 'package:movie_buff/response/video_response.dart';
import 'package:movie_buff/service/service_util.dart';
import 'package:rxdart/rxdart.dart';

class MovieVideoInfoBloc {
  final ServiceUtil _serviceUtil = ServiceUtil();
  final BehaviorSubject<VideoInfoResponse> _bhSubject = BehaviorSubject<VideoInfoResponse>();

  getMovieVideoInfo(int movieId) async {
    VideoInfoResponse response = await _serviceUtil.inquireMovieVideosById(movieId);
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

  BehaviorSubject<VideoInfoResponse> get subject => _bhSubject;
}

final movieVideoInfoBloc = MovieVideoInfoBloc();
