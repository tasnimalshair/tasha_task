import 'package:logger/logger.dart';

class ServicesModel {
  int? rv;
  String? msg;
  List<ServiceData>? data;

  ServicesModel({this.rv, this.msg, this.data});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    rv = json['rv'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <ServiceData>[];
      json['data'].forEach((v) {
        data!.add(new ServiceData.fromJson(v));
      });
    }
  }
}

class ServiceData {
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

  ServiceData.fromJson(Map<String, dynamic> json) {
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
