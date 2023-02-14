class StoryModel {
  int? storiesID;
  int? iD;
  String? fileName;
  int? fileType;
  int? sorting;

  StoryModel.fromJson(Map<String, dynamic> json) {
    storiesID = json['StoriesID'];
    iD = json['ID'];
    fileName = json['FileName'];
    fileType = json['FileType'];
    sorting = json['Sorting'];
  }

}