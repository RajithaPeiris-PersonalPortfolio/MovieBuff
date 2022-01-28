import 'package:movie_buff/response/trending_person_response.dart';
import 'package:movie_buff/service/service_util.dart';
import 'package:rxdart/rxdart.dart';

class TrendingPersonBloc {
  final ServiceUtil _serviceUtil = ServiceUtil();
  final BehaviorSubject<TrendingPersonResponse> _bhSubject = BehaviorSubject<TrendingPersonResponse>();

  getTrendingPersonsInfo() async {
    TrendingPersonResponse response = await _serviceUtil.inquireAllTrendingPersonsInfo();
    _bhSubject.sink.add(response);
  }

  dispose() {
    _bhSubject.close();
  }

  BehaviorSubject<TrendingPersonResponse> get subject => _bhSubject;
  
}
final trendingPersonBloc = TrendingPersonBloc();