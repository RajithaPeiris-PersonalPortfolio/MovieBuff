import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_buff/bloc/get_now_playing_bloc.dart';
import 'package:movie_buff/model/movie_main.dart';
import 'package:movie_buff/model/user.dart';
import 'package:movie_buff/response/movie_main_response.dart';
import 'package:movie_buff/screen/movie_video.dart';
import 'package:page_indicator/page_indicator.dart';

import 'package:movie_buff/screen/color_theme.dart' as Theme;

class NowPlaying extends StatefulWidget {
  final User user;
  NowPlaying({Key? key, required this.user}) : super(key: key);
  @override
  _NowPlayingState createState() => _NowPlayingState(user);
}

class _NowPlayingState extends State<NowPlaying> {
  final User user;
  _NowPlayingState(this.user);

  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    super.initState();
    nowPlayingMoviesBloc..getNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieMainResponse>(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieMainResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.error != null && snapshot.data!.error!="") {
            String? errorVal = snapshot.data?.error;
            return _buildErrorWidget(errorVal!);
          }
          return _buildHomeWidget(snapshot.data!);
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
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
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

  Widget _buildHomeWidget(MovieMainResponse data) {
    List<MovieMain> movies = data.movieMainInfo;
    if (movies.isEmpty) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Movies",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 220.0,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          length: movies.take(5).length,
          indicatorSpace: 8.0,
          padding: const EdgeInsets.all(5.0),
          indicatorColor: Theme.Colors.titleColor,
          indicatorSelectorColor: Theme.Colors.secondColor,
          shape: IndicatorShape.circle(size: 5.0),
          child: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: movies.take(5).length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MovieVideo(movie: movies[index], user: user,),
                    ),
                  );
                },
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: movies[index].id,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 220.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/original/" +
                                      movies[index].coverImage)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [
                              0.0,
                              0.9
                            ],
                            colors: [
                              Theme.Colors.mainColor.withOpacity(1.0),
                              Theme.Colors.mainColor.withOpacity(0.0)
                            ]),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      top: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Icon(
                        FontAwesomeIcons.playCircle,
                        color: Theme.Colors.secondColor,
                        size: 40.0,
                      ),
                    ),
                    Positioned(
                        bottom: 30.0,
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          width: 250.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                movies[index].movieTitle,
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              );
            },
          ),
        ),
      );
  }
}
