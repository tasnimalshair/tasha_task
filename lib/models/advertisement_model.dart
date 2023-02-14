class AdvertisementModel {
  int? iD;
  String? createDateTime;
  String? endDateTime;
  int? userIDAdd;
  String? fileName;
  int? fileType;

  AdvertisementModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createDateTime = json['CreateDateTime'];
    endDateTime = json['EndDateTime'];
    userIDAdd = json['UserIDAdd'];
    fileName = json['FileName'];
    fileType = json['FileType'];
  }
}
