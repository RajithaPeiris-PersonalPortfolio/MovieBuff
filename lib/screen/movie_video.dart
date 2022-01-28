import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_buff/bloc/get_movie_videos_bloc.dart';
import 'package:movie_buff/model/movie_main.dart';
import 'package:movie_buff/model/user.dart';
import 'package:movie_buff/model/video.dart';
import 'package:movie_buff/response/video_response.dart';

import 'package:movie_buff/screen/color_theme.dart' as Theme;
import 'package:movie_buff/widgets/movie_info.dart';
import 'package:movie_buff/widgets/owners.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'movie_detail_inquiry_screen.dart';

class MovieVideo extends StatefulWidget {
  final MovieMain movie;
  final User user;
  MovieVideo({Key? key, required this.movie, required this.user}) : super(key: key);

  @override
  _MovieVideoState createState() => _MovieVideoState(movie, user);
}

class _MovieVideoState extends State<MovieVideo> {
  final MovieMain movie;
  final User user;
  _MovieVideoState(this.movie, this.user);

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

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'Bh8NeyejykU',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
      hideThumbnail: false,
      hideControls: false,
      controlsVisibleAtStart: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.Colors.mainColor,
      body: new Builder(
        builder: (context) {
          return new StreamBuilder<VideoInfoResponse>(
              stream: movieVideoInfoBloc.subject.stream,
              builder: (context, AsyncSnapshot<VideoInfoResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data?.error != null && snapshot.data!.error!="") {
                    String? errorVal = snapshot.data?.error;
                    return _buildErrorWidget(errorVal!);
                  }
                  return _buildVideoWidget(snapshot.data!);
                } else if (snapshot.hasError) {
                  return _buildErrorWidget(snapshot.error.toString());
                } else {
                  return _buildLoadingWidget();
                }
              },
            );
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    print("loading video");
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ));
  }

  Widget _buildErrorWidget(String error) {
    print("playing error video");
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
    print("videos");
    print(videos[0].key);
    return Scaffold(
      backgroundColor: Theme.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Theme.Colors.mainColor,
        centerTitle: true,
        leading: Icon(EvaIcons.menu2Outline, color: Colors.white,),
        title: Text(
          movie.movieTitle,
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieDetailInquiryScreen(movie: movie,user: user),
                  ),
                );
              },
              icon: Icon(EvaIcons.arrowBack, color: Colors.white,)
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 220.0,
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videos[0].key,
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                  hideThumbnail: false,
                  hideControls: false,
                  controlsVisibleAtStart: true,
                ),
              ),
              showVideoProgressIndicator: true,
              controlsTimeOut: Duration(seconds: 20),
              //videoProgressIndicatorColor: Colors.amber,
              /*progressColors: ProgressColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),*/
              /*onReady () {
                _controller.addListener(listener);
              },*/
            ),
          ),
          MovieInfomation(id: movie.id),
          Owners(id: movie.id),
        ],
      ),
    );
  }
}
