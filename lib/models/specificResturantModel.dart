class SpecificResturantModel {
  int? rv;
  String? msg;
  List<Data>? data;


  SpecificResturantModel.fromJson(Map<String, dynamic> json) {
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
  int? iD;
  int? sectionType;
  String? name;
  String? description;
  int? rate;
  int? defaultPrice;
  String? addressDetails;
  String? latitude;
  String? longitude;
  String? mobileNumber;
  bool? active;
  int? addressID;
  List<Pictures>? pictures;
  int? discount;


  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    sectionType = json['SectionType'];
    name = json['Name'];
    description = json['Description'];
    rate = json['Rate'];
    defaultPrice = json['DefaultPrice'];
    addressDetails = json['AddressDetails'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    mobileNumber = json['MobileNumber'];
    active = json['Active'];
    addressID = json['AddressID'];
    if (json['Pictures'] != null) {
      pictures = <Pictures>[];
      json['Pictures'].forEach((v) {
        pictures!.add(new Pictures.fromJson(v));
      });
    }
    discount = json['Discount'];
  }

 
}

class Pictures {
  String? fileName;

  Pictures.fromJson(Map<String, dynamic> json) {
    fileName = json['FileName'];
  }


}