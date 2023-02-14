class EntertainmentServiceModel {
  int? iD;
  int? sectionTypeID;
  String? iconFile;
  String? title;
  int? sorting;

  EntertainmentServiceModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    sectionTypeID = json['SectionTypeID'];
    iconFile = json['IconFile'];
    title = json['Title'];
    sorting = json['Sorting'];
  }

}