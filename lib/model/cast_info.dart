class CastInfo {
  late int id;
  late String castCharacter;
  late String name;
  late String profileImage;

  CastInfo(
      this.id,
      this.castCharacter,
      this.name,
      this.profileImage
      );


  //CastInfo.convertToCastInfo(i);

  CastInfo.convertToCastInfo(Map<String, dynamic> mapObj) {
    //final mapObj = Map<String, dynamic> ();
    //if(id!=null) {
    id = mapObj['cast_id'];
    //}
    castCharacter = mapObj['character'];
    name = mapObj['name'];

    if (mapObj['profile_path']!=null) {
      profileImage = mapObj['profile_path'];
    }

    //return mapObj;
  }
}