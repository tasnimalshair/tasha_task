class SectionPriceModel {
  int? sectionID;
  int? iD;
  int? bookingID;
  int? periodType;
  int? price;
  int? sorting;
  int? cur;
  String? bookingName;
  String? periodTypeName;
  String? currency;
  int? discount;


  SectionPriceModel.fromJson(Map<String, dynamic> json) {
    sectionID = json['SectionID'];
    iD = json['ID'];
    bookingID = json['BookingID'];
    periodType = json['PeriodType'];
    price = json['Price'];
    sorting = json['Sorting'];
    cur = json['Cur'];
    bookingName = json['BookingName'];
    periodTypeName = json['PeriodTypeName'];
    currency = json['Currency'];
    discount = json['Discount'];
  }

}