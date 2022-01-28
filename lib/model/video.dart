class VideoInfo {
  String? id;
  late String key;
  late String name;
  late String site;
  late String type;

  VideoInfo (this.id, this.key,
      this.name, this.site, this.type);

  VideoInfo.convertToVideoInfo(Map<String, dynamic> mapObj) {
    //if(id!=null) {
      id = mapObj['id'];
    //}
      key = mapObj['key'];
      name = mapObj['name'];
      site = mapObj['site'];
      type = mapObj['type'];
    //return mapObj;
  }

}