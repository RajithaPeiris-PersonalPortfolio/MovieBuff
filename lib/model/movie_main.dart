class MovieMain {
  late int id;
  late double trendingStatus;
  late String movieTitle;
  late String coverImage;
  late String frontImage;
  late String overview;
  late double voteCoverage;

  MovieMain(this.id, this.trendingStatus, this.movieTitle,
      this.coverImage, this.frontImage, this.overview, this.voteCoverage);

  MovieMain.convertToMovieMainInfo(Map<String, dynamic> mapObj) {
    //if(id!=null) {
    id = mapObj['id'];
    //}


    trendingStatus = double.parse(mapObj['popularity'].toString());
    movieTitle = mapObj['title'];
    if(mapObj['backdrop_path']!=null) {
      coverImage = mapObj['backdrop_path'];
    }

    if(mapObj['poster_path']!=null) {
      frontImage = mapObj['poster_path'];
    } else {
      frontImage = "/kqjL17yufvn9OVLyXYpvtyrFfak.jpg";
    }

    overview = mapObj['overview'];
    voteCoverage = mapObj['vote_average'].toDouble();

    //return mapObj;
  }
}