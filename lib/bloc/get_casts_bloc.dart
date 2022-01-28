import 'package:flutter/material.dart';
import 'package:movie_buff/response/cast_info_response.dart';
import 'package:movie_buff/service/service_util.dart';
import 'package:rxdart/rxdart.dart';

class CastInfoBloc {
  final ServiceUtil _serviceUtil = ServiceUtil();
  final BehaviorSubject<CastInfoResponse> _bhSubject = BehaviorSubject<CastInfoResponse>();

  getAllCasts(int id) async {
    CastInfoResponse response = await _serviceUtil.inquireMovieCastInfoById(id);
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

  BehaviorSubject<CastInfoResponse> get subject => _bhSubject;
}

final castInfoBloc = CastInfoBloc();
