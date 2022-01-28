import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_buff/bloc/get_movie_videos_bloc.dart';
import 'package:movie_buff/model/movie_main.dart';
import 'package:movie_buff/model/video.dart';
import 'package:movie_buff/response/video_response.dart';
import 'package:movie_buff/screen/yt_player.dart';
import 'package:movie_buff/widgets/cast_Info.dart';
import 'package:movie_buff/widgets/movie_info.dart';
import 'package:movie_buff/widgets/similar_movies.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:movie_buff/screen/color_theme.dart' as Theme;

class MovieDetailScreen extends StatefulWidget {
  final MovieMain movie;
  MovieDetailScreen({required this.movie}) : super();
  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState(movie);
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final MovieMain movie;
  _MovieDetailScreenState(this.movie);

  @override
  void initState() {
    super.initState();
    movieVideoInfoBloc..getMovieVideoInfo(movie.id);
  }

  @override
  void dispose() {
    super.dispose();
    movieVideoInfoBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.Colors.mainColor,
      body: new Builder(
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              children: <Widget>[
                new AppBar(
                  backgroundColor: Theme.Colors.mainColor,
                  //expandedHeight: 200.0,
                  //pinned: true,
                  flexibleSpace: new FlexibleSpaceBar(
                      title: Text(
                        movie.movieTitle,
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.normal),
                      ),
                      background: Stack(
                        children: <Widget>[
                          Container(
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/original/" +
                                          movie.coverImage)),
                            ),
                            child: new Container(
                              decoration: new BoxDecoration(
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: [
                                    0.1,
                                    0.9
                                  ],
                                  colors: [
                                    Colors.black.withOpacity(0.9),
                                    Colors.black.withOpacity(0.0)
                                  ]),
                            ),
                          ),
                        ],
                      )),
                ),
                //Padding(
                   // padding: EdgeInsets.all(0.0),
                    //child: ListView(
                        //delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              movie.trendingStatus.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            RatingBar(
                              itemSize: 10.0,
                              initialRating: movie.trendingStatus / 2,
                              ratingWidget: RatingWidget(
                                empty: Icon(
                                  EvaIcons.star,
                                  color: Theme.Colors.secondColor,
                                ),
                                full: Icon(
                                  EvaIcons.star,
                                  color: Theme.Colors.secondColor,
                                ),
                                half: Icon(
                                  EvaIcons.star,
                                  color: Theme.Colors.secondColor,
                                ),
                              ),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: Text(
                          "OVERVIEW",
                          style: TextStyle(
                              color: Theme.Colors.titleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          movie.overview,
                          style: TextStyle(
                              color: Colors.white, fontSize: 12.0, height: 1.5),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ), MovieInfomation(
                        id: movie.id,
                      ),
                      Casts(
                        id: movie.id,
                      ),
                      //SimilarMovies(id: movie.id)
                    //])))
              ],
            ),
          );
        },
      ),
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

  Widget _buildVideoWidget(VideoInfoResponse data) {
    List<VideoInfo> videos = data.videoInfo;
    return FloatingActionButton(
      backgroundColor: Theme.Colors.secondColor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(
              controller: YoutubePlayerController(
                initialVideoId: videos[0].key,
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                  mute: true,
                ),
              ),
            ),
          ),
        );
      },
      child: Icon(Icons.play_arrow),
    );
  }
}
