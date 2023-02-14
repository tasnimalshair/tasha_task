class ManagerRequestModel {
  int? rv;
  String? msg;
  String? data;

  ManagerRequestModel({this.rv, this.msg, this.data});

  ManagerRequestModel.fromJson(Map<String, dynamic> json) {
    rv = json['rv'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rv'] = this.rv;
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }
}