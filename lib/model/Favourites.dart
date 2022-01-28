class FavouritesModel {
  late String? key;
  late String name;
  late String username;
  late String date;
  late String movie_name;
  late int movie_id;
  late double trending_status;
  late String coverImage;
  late String front_image;
  late double vote_coverage;

  FavouritesModel(
    this.key,
    this.name,
    this.username,
    this.date,
    this.movie_name,
    this.movie_id,
    this.trending_status,
    this.coverImage,
    this.front_image,
    this.vote_coverage
  );


}