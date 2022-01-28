class Owner {
  int? id;
  late String companyLogo;
  late String name;
  late String country;

  Owner(
      this.id, this.companyLogo,
      this.name, this.country,
      );

  Owner.convertToOwnerInfo(Map<String, dynamic> mapObj) {
    //if(id!=null) {
    id = mapObj['id'];
    //}

    if (mapObj['logo_path']!=null) {
      companyLogo = mapObj['logo_path'];
    }
    name = mapObj['name'];
    country = mapObj['origin_country'];
    //return mapObj;
  }


}