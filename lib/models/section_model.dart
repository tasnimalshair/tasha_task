class SectionModel {
  int? iD;
  String? title;
  String? fileName;
  int? sorting;
  bool? foodMenu;
  bool? booking;
  bool? allowConflictSchedule;


  SectionModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    title = json['Title'];
    fileName = json['FileName'];
    sorting = json['Sorting'];
    foodMenu = json['FoodMenu'];
    booking = json['Booking'];
    allowConflictSchedule = json['AllowConflictSchedule'];
  }
}