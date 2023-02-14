class ConfirmModel {
  int? rv;
  String? msg;
  List? data;

  ConfirmModel({this.rv, this.msg, this.data});

  ConfirmModel.fromJson(Map<String, dynamic> json) {
    rv = json['rv'];
    msg = json['msg'];
    data = json['data'];
  }
}