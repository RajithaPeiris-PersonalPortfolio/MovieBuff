class TrendingPerson {
  late int id;
  late double trendingStatus;
  late String name;
  late String profileImage;
  late String knownForDepartment;

  TrendingPerson(
      this.id, this.trendingStatus, this.name,
      this.profileImage, this.knownForDepartment
      );

  TrendingPerson.convertToTrendingPersonInfo(Map<String, dynamic> mapObj) {
    //if(id!=null) {
    id = mapObj['id'];
    //}
    trendingStatus = mapObj['popularity'];
    name = mapObj['name'];

    if (mapObj['profile_path']!=null) {
      profileImage = mapObj['profile_path'];
    } else {
      profileImage = "no-image";
    }

    knownForDepartment = mapObj['known_for_department'];
    //return mapObj;
  }
}