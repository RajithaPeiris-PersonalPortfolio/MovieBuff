import 'package:flutter/material.dart';
import 'package:movie_buff/bloc/get_movie_detail_bloc.dart';
import 'package:movie_buff/model/movie_info.dart';
import 'package:movie_buff/response/movie_info_response.dart';

import 'package:movie_buff/screen/color_theme.dart' as Theme;

class MovieInfomation extends StatefulWidget {
  final int id;
  MovieInfomation({required this.id}) : super();
  @override
  _MovieInfoState createState() => _MovieInfoState(id);
}

class _MovieInfoState extends State<MovieInfomation> {
  final int id;
  _MovieInfoState(this.id);
  @override
  void initState() {
    super.initState();
    movieDetailBloc..getMovieInfoById(id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieInfoResponse>(
      stream: movieDetailBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieInfoResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.error != null && snapshot.data!.error!="") {
            String? errorVal = snapshot.data?.error;
            return _buildErrorWidget(errorVal!);
          }
          return _buildMovieDetailWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        } else {
          return _buildLoadingWidget();
        }
      },
    );
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

  Widget _buildMovieDetailWidget(MovieInfoResponse data) {
    MovieInfo detail = data.movieInfo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "BUDGET",
                    style: TextStyle(
                        color: Theme.Colors.titleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    detail.budget.toString() + "\$",
                    style: TextStyle(
                        color: Theme.Colors.secondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "DURATION",
                    style: TextStyle(
                        color: Theme.Colors.titleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(detail.movieRuntime.toString() + "min",
                      style: TextStyle(
                          color: Theme.Colors.secondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "RELEASE DATE",
                    style: TextStyle(
                        color: Theme.Colors.titleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(detail.releaseDate,
                      style: TextStyle(
                          color: Theme.Colors.secondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0))
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "CATEGORIES",
                style: TextStyle(
                    color: Theme.Colors.titleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 38.0,
                padding: EdgeInsets.only(right: 10.0, top: 10.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: detail.movieCategory.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border:
                                Border.all(width: 1.0, color: Colors.orangeAccent)),
                        child: Text(
                          detail.movieCategory[index].name,
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.4,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9.0),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
