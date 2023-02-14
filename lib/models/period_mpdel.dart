class PeriodModel {
  int? code;
  String? name;

  PeriodModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    name = json['Name'];
  }
}