class MovieCategory {
  late int id;
  late String name;

  MovieCategory(this.id, this.name);

  MovieCategory.convertToMovieCategoryInfo(Map<String, dynamic> mapObj) {
    id = mapObj['id'];
    name = mapObj['name'];
    //return mapObj;
  }
}