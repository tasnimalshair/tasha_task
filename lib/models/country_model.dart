class CountryModel {
  int? rv;
  String? msg;
  List<Data>? data;

  CountryModel.fromJson(Map<String, dynamic> json) {
    rv = json['rv'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

}

class Data {
  int? countryID;
  int? iD;
  String? name;
  String? parent;


  Data.fromJson(Map<String, dynamic> json) {
    countryID = json['CountryID'];
    iD = json['ID'];
    name = json['Name'];
    parent = json['Parent'];
  }
}