class EditModel {
  Null? fileName;
  int? rv;
  String? msg;
  List<Data>? data;

  EditModel({this.fileName, this.rv, this.msg, this.data});

  EditModel.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    rv = json['rv'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['rv'] = this.rv;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? userID;
  String? userName;
  String? firstName;
  String? lastName;
  int? addressID;
  String? addressName;
  String? addressDetails;
  String? mobileNumber;
  int? gender;
  String? genderName;
  String? birthDate;
  String? password;
  Null? email;
  Null? facebookID;
  Null? city;
  Null? cityName;
  Null? googleID;
  bool? active;
  String? createDate;
  String? photo;
  int? country;
  String? countryName;

  Data(
      {this.userID,
        this.userName,
        this.firstName,
        this.lastName,
        this.addressID,
        this.addressName,
        this.addressDetails,
        this.mobileNumber,
        this.gender,
        this.genderName,
        this.birthDate,
        this.password,
        this.email,
        this.facebookID,
        this.city,
        this.cityName,
        this.googleID,
        this.active,
        this.createDate,
        this.photo,
        this.country,
        this.countryName});

  Data.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    addressID = json['addressID'];
    addressName = json['addressName'];
    addressDetails = json['addressDetails'];
    mobileNumber = json['mobileNumber'];
    gender = json['gender'];
    genderName = json['genderName'];
    birthDate = json['birthDate'];
    password = json['password'];
    email = json['email'];
    facebookID = json['facebookID'];
    city = json['city'];
    cityName = json['cityName'];
    googleID = json['GoogleID'];
    active = json['Active'];
    createDate = json['CreateDate'];
    photo = json['photo'];
    country = json['country'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['addressID'] = this.addressID;
    data['addressName'] = this.addressName;
    data['addressDetails'] = this.addressDetails;
    data['mobileNumber'] = this.mobileNumber;
    data['gender'] = this.gender;
    data['genderName'] = this.genderName;
    data['birthDate'] = this.birthDate;
    data['password'] = this.password;
    data['email'] = this.email;
    data['facebookID'] = this.facebookID;
    data['city'] = this.city;
    data['cityName'] = this.cityName;
    data['GoogleID'] = this.googleID;
    data['Active'] = this.active;
    data['CreateDate'] = this.createDate;
    data['photo'] = this.photo;
    data['country'] = this.country;
    data['countryName'] = this.countryName;
    return data;
  }
}