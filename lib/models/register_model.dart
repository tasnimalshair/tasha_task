class RegisterModel {
  String? fileName;
  int? rv;
  String? msg;
  List<Data>? data;


  RegisterModel.fromJson(Map<String, dynamic> json) {
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

}

class Data {
  String? fCMToken;
  String? msgTxt;


  Data.fromJson(Map<String, dynamic> json) {
    fCMToken = json['FCMToken'];
    msgTxt = json['MsgTxt'];
  }
}