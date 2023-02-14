class MenuModel {
  int? sectionID;
  int? iD;
  String? fileName;
  int? sorting;


  MenuModel.fromJson(Map<String, dynamic> json) {
    sectionID = json['SectionID'];
    iD = json['ID'];
    fileName = json['FileName'];
    sorting = json['Sorting'];
  }

}