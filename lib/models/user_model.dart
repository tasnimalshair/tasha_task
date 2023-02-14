import 'package:hive/hive.dart';
import 'package:random_string/random_string.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class LoginModel {
  LoginModel();
  @HiveField(0)
  int? rv;
  @HiveField(1)
  String? msg;
  @HiveField(2)
  UserVM? userVM;
  @HiveField(3)
  String? token;


  LoginModel.fromJson(Map<String, dynamic> json) {
    rv = json['rv'];
    msg = json['msg'];
    userVM =
    json['userVM'] != null ? new UserVM.fromJson(json['userVM']) : null;
    token = json['token'];
  }

}
@HiveType(typeId: 1)
class UserVM {
  UserVM();
  @HiveField(0) int? userID;
  @HiveField(1) String? userName;
  @HiveField(2) String? sectionType;
  @HiveField(3) String? firstName;
  @HiveField(4) String? lastName;
  @HiveField(5) String? addressDetails;
  @HiveField(6) String? city;
  @HiveField(7) String? cityName;
  @HiveField(8) int? addressID;
  @HiveField(9) String? addressName;
  @HiveField(10) int? country;
  @HiveField(11) String? countryName;
  @HiveField(12) String? mobileNumber;
  @HiveField(13) int? gender;
  @HiveField(14) String? genderName;
  @HiveField(15) String? birthDate;
  @HiveField(16) String? password;
  @HiveField(17) String? email;
  @HiveField(18) String? faceBookID;
  @HiveField(19) String? googleID;
  @HiveField(20) bool? active;
  @HiveField(21) String? createDate;
  @HiveField(22) String? photo;
  @HiveField(23) String? fcmToken;

  UserVM.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    userName = json['userName'];
    sectionType = json['sectionType'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    addressDetails = json['addressDetails'];
    city = json['city'];
    cityName = json['cityName'];
    addressID = json['addressID'];
    addressName = json['addressName'];
    country = json['country'];
    countryName = json['countryName'];
    mobileNumber = json['mobileNumber'];
    gender = json['gender'];
    genderName = json['genderName'];
    birthDate = json['birthDate'];
    password = json['password'];
    email = json['email'];
    faceBookID = json['faceBookID'];
    googleID = json['googleID'];
    active = json['active'];
    createDate = json['createDate'];
    photo = json['photo'];
    fcmToken = json['fcmToken'];
  }

}