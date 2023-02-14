class AreaModel {
  int? countryID;
  int? iD;
 late String name;
  String? parent;


  AreaModel.fromJson(Map<String, dynamic> json) {
    countryID = json['CountryID'];
    iD = json['ID'];
    name = json['Name'];
    parent = json['Parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CountryID'] = this.countryID;
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['Parent'] = this.parent;
    return data;
  }
}