import 'package:flutter/material.dart';
import 'package:movie_buff/bloc/get_movie_detail_bloc.dart';
import 'package:movie_buff/model/movie_info.dart';
import 'package:movie_buff/response/movie_info_response.dart';

import 'package:movie_buff/screen/color_theme.dart' as Theme;

class MovieOverview extends StatefulWidget {
  final String overviewInfo;
  MovieOverview({required this.overviewInfo}) : super();
  @override
  _MovieOverviewState createState() => _MovieOverviewState(overviewInfo);
}

class _MovieOverviewState extends State<MovieOverview> {
  final String overviewInfo;
  _MovieOverviewState(this.overviewInfo);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildMovieDetailWidget();;
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildMovieDetailWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "OVERVIEW",
                style: TextStyle(
                    color: Theme.Colors.titleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 90,
                padding: EdgeInsets.only(top: 5.0),
                child: Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border:
                                Border.all(width: 1.0, color: Colors.orangeAccent)),
                        child: Text(
                          overviewInfo,
                          maxLines: 6,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0),
                        ),
                      ),
                    ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
