import 'package:dio/dio.dart';
import 'package:movie_buff/response/cast_info_response.dart';
import 'package:movie_buff/response/movie_category_response.dart';
import 'package:movie_buff/response/movie_info_response.dart';
import 'package:movie_buff/response/movie_main_response.dart';
import 'package:movie_buff/response/trending_person_response.dart';
import 'package:movie_buff/response/video_response.dart';

class ServiceUtil {

  static String apiUrl = "https://api.themoviedb.org/3";
  final String apiKey = "8a1227b5735a7322c4a43a461953d4ff";
  final String language = "en-US";
  final String page = "1";
  late Map<String, dynamic> emptyResponseValue = {};

  final String data = "data";
  final String errorValue = "error";

  final Dio _dioClient = Dio();

  Future<MovieCategoryResponse> inquireMovieCategoryList() async {
    var params = {
      "api_key":apiKey,
      "language": language,
    };

    try {
      Response responseVal = await _dioClient.get('$apiUrl/genre/movie/list', queryParameters: params);
      print(responseVal.data.toString());
      return MovieCategoryResponse.convertToCategoryInfoResponse(responseVal.data, errorValue, data);
    } catch (error, stacktrace) {
      print("Unhandled exception occurred during service invoke : error => $error stackTrace => $stacktrace");
      return MovieCategoryResponse.convertToCategoryInfoResponse(emptyResponseValue, "$error", errorValue);
    }
  }

  Future<MovieMainResponse> inquireAllMovies() async {
    var params = {
      "api_key":apiKey,
      "language": language,
      "page": page
    };

    try {
      Response responseVal = await _dioClient.get('$apiUrl/movie/top_rated', queryParameters: params);
      print(responseVal.data);
      return MovieMainResponse.convertToMovieMainInfoResponse(responseVal.data, errorValue, data);
    } catch (error, stacktrace) {
      print("Unhandled exception occurred during service invoke : error => $error stackTrace => $stacktrace");
      return MovieMainResponse.convertToMovieMainInfoResponse(emptyResponseValue, "$error", errorValue);
    }
  }

  Future<MovieMainResponse> inquireAllMoviesByCategory(int categoryId) async {
    var params = {
      "api_key":apiKey,
      "with_genres": categoryId,
      "language": language,
      "page": page
    };

    try {
      Response responseVal = await _dioClient.get('$apiUrl/discover/movie', queryParameters: params);
      print(responseVal.data);
      return MovieMainResponse.convertToMovieMainInfoResponse(responseVal.data, errorValue, data);
    } catch (error, stacktrace) {
      print("Unhandled exception occurred during service invoke : error => $error stackTrace => $stacktrace");
      return MovieMainResponse.convertToMovieMainInfoResponse(emptyResponseValue, "$error", errorValue);
    }
  }

  Future<MovieInfoResponse> inquireMovieInfoById(int movieId) async {
    var params = {
      "api_key":apiKey,
      "language": language,
    };

    try {
      Response responseVal = await _dioClient.get('$apiUrl/movie/$movieId', queryParameters: params);
      print(responseVal.data);
      return MovieInfoResponse.convertToMovieInfoResponse(responseVal.data, errorValue, data);
    } catch (error, stacktrace) {
      print("Unhandled exception occurred during service invoke : error => $error stackTrace => $stacktrace");
      return MovieInfoResponse.convertToMovieInfoResponse(emptyResponseValue, "$error", errorValue);
    }
  }

  Future<VideoInfoResponse> inquireMovieVideosById(int movieId) async {
    var params = {
      "api_key":apiKey,
      "language": language,
    };

    try {
      Response responseVal = await _dioClient.get('$apiUrl/movie/$movieId/videos', queryParameters: params);
      print(responseVal.data);
      return VideoInfoResponse.convertToVideoInfoResponse(responseVal.data, errorValue, data);
    } catch (error, stacktrace) {
      print("Unhandled exception occurred during service invoke : error => $error stackTrace => $stacktrace");
      return VideoInfoResponse.convertToVideoInfoResponse(emptyResponseValue, "$error", errorValue);
    }
  }

  Future<CastInfoResponse> inquireMovieCastInfoById(int movieId) async {
    var params = {
      "api_key":apiKey,
      "language": language,
    };

    try {
      Response responseVal = await _dioClient.get('$apiUrl/movie/$movieId/credits', queryParameters: params);
      print(responseVal.data);
      return CastInfoResponse.convertToCastInfoResponse(responseVal.data, errorValue, data);
    } catch (error, stacktrace) {
      print("Unhandled exception occurred during service invoke : error => $error stackTrace => $stacktrace");
      return CastInfoResponse.convertToCastInfoResponse(emptyResponseValue, "$error", errorValue);
    }
  }

  Future<MovieMainResponse> inquireNowPlaying() async {
    var params = {
      "api_key":apiKey,
      "language": language,
      "page": page
    };

    try {
      Response responseVal = await _dioClient.get('$apiUrl/movie/now_playing', queryParameters: params);
      print(responseVal.data.toString());
      return MovieMainResponse.convertToMovieMainInfoResponse(responseVal.data, errorValue, data);
    } catch (error, stacktrace) {
      print("Unhandled exception occurred during service invoke : error => $error stackTrace => $stacktrace");
      return MovieMainResponse.convertToMovieMainInfoResponse(emptyResponseValue, "$error", errorValue);
    }
  }

  Future<MovieMainResponse> inquireSimilarMovies(int movieId) async {
    var params = {
      "api_key":apiKey,
      "language": language
    };

    try {
      print("9999999999999");
      print("$apiUrl/movie/$movieId/similar?api_key=8a1227b5735a7322c4a43a461953d4ff&language=en-US");
      Response responseVal = await _dioClient.get('$apiUrl/movie/$movieId/similar?api_key=8a1227b5735a7322c4a43a461953d4ff&language=en-US');
      print("888888888888888888");
      print(responseVal.data.toString());
      return MovieMainResponse.convertToMovieMainInfoResponse(responseVal.data, errorValue, data);
    } catch (error, stacktrace) {
      print("Unhandled exception occurred during service invoke : error => $error stackTrace => $stacktrace");
      return MovieMainResponse.convertToMovieMainInfoResponse(emptyResponseValue, "$error", errorValue);
    }
  }

  Future<TrendingPersonResponse> inquireAllTrendingPersonsInfo() async {
    var params = {
      "api_key":apiKey
    };

    try {
      Response responseVal = await _dioClient.get('$apiUrl/trending/person/week', queryParameters: params);
      return TrendingPersonResponse.convertToTrendingPersonInfoResponse(responseVal.data, errorValue, data);
    } catch (error, stacktrace) {
      print("Unhandled exception occurred during service invoke : error => $error stackTrace => $stacktrace");
      return TrendingPersonResponse.convertToTrendingPersonInfoResponse(emptyResponseValue, "$error", errorValue);
    }
  }

  Future<MovieMainResponse> searchMovies(String searchQuery) async {
    var params = {
      "api_key":apiKey,
      "language": language,
      "query": searchQuery,
      "include_adult": true,
      "page": page
    };

    try {
      print("9999999999999");
      //print("$apiUrl/movie/$movieId/similar?api_key=8a1227b5735a7322c4a43a461953d4ff&language=en-US");
      Response responseVal = await _dioClient.get('$apiUrl/search/movie', queryParameters: params);
      return MovieMainResponse.convertToMovieMainInfoResponse(responseVal.data, errorValue, data);
    } catch (error, stacktrace) {
      print("Unhandled exception occurred during service invoke : error => $error stackTrace => $stacktrace");
      return MovieMainResponse.convertToMovieMainInfoResponse(emptyResponseValue, "$error", errorValue);
    }
  }
}