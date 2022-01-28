import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_buff/bloc/get_movies_by_category_bloc.dart';
import 'package:movie_buff/model/movie_main.dart';
import 'package:movie_buff/model/user.dart';
import 'package:movie_buff/response/movie_main_response.dart';
import 'package:movie_buff/screen/color_theme.dart' as Theme;
import 'package:movie_buff/screen/movie_detail_inquiry_screen.dart';

class MovieByCategory extends StatefulWidget {
  final int genreId;
  final User user;
  MovieByCategory({required this.genreId, required this.user}) : super();
  @override
  _GenreMoviesState createState() => _GenreMoviesState(genreId, user);
}

class _GenreMoviesState extends State<MovieByCategory> {
  final int categoryId;
  final User user;
  _GenreMoviesState(this.categoryId, this.user);
  @override
  void initState() {
    super.initState();
    moviesByMovieCtegoryBloc..getMoviesByCategory(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieMainResponse>(
      stream: moviesByMovieCtegoryBloc.subject.stream,
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
    if (movies.length == 0) {
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
        height: 270.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailInquiryScreen(movie: movies[index], user: user,),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    movies[index].frontImage == null
                        ? Container(
                            width: 120.0,
                            height: 180.0,
                            decoration: new BoxDecoration(
                              color: Theme.Colors.secondColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  EvaIcons.filmOutline,
                                  color: Colors.white,
                                  size: 60.0,
                                )
                              ],
                            ),
                          )
                        : Container(
                            width: 120.0,
                            height: 180.0,
                            decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              shape: BoxShape.rectangle,
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w200/" +
                                          movies[index].frontImage)),
                            )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        movies[index].movieTitle,
                        maxLines: 2,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          movies[index].trendingStatus.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        RatingBar(
                          itemSize: 8.0,
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
                          initialRating: movies[index].trendingStatus / movies[index].voteCoverage,
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
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
