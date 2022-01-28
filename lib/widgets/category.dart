import 'package:flutter/material.dart';
import 'package:movie_buff/bloc/get_movie_category_bloc.dart';
import 'package:movie_buff/model/movie_category.dart';
import 'package:movie_buff/model/user.dart';
import 'package:movie_buff/response/movie_category_response.dart';
import 'package:movie_buff/widgets/movie_category_list.dart';

class CategoryScreen extends StatefulWidget {
  final User user;
  CategoryScreen({Key? key, required this.user}) : super(key: key);
  @override
  _CategoryScreenState createState() => _CategoryScreenState(user);
}

class _CategoryScreenState extends State<CategoryScreen>{
  final User user;
_CategoryScreenState(this.user);


  @override
  void initState() {
    super.initState();
    categoryBloc..getAllMovieCategory();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieCategoryResponse>(
        stream: categoryBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieCategoryResponse> snapshot) {
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
            valueColor:
                new AlwaysStoppedAnimation<Color>(Colors.white),
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

  Widget _buildHomeWidget(MovieCategoryResponse data) {
    List<MovieCategory> genres = data.movieCategoryInfo;
    print(genres);
    if (genres.isEmpty) {
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
      return CategoryList(genres: genres, user: user);
  }
}
