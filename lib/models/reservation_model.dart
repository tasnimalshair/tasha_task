class ReservationModel {
  int? iD;
  String? reservationDateFrom;
  String? reservationDateTo;
  String? periodName;
  String? bookingName;
  String? statusName;
  bool? approved;
  String? paidTypeName;
  int? totalAmount;
  String? sectionName;

  ReservationModel(
      {this.iD,
        this.reservationDateFrom,
        this.reservationDateTo,
        this.periodName,
        this.bookingName,
        this.statusName,
        this.approved,
        this.paidTypeName,
        this.totalAmount,
        this.sectionName});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    reservationDateFrom = json['ReservationDateFrom'];
    reservationDateTo = json['ReservationDateTo'];
    periodName = json['PeriodName'];
    bookingName = json['BookingName'];
    statusName = json['StatusName'];
    approved = json['Approved'];
    paidTypeName = json['PaidTypeName'];
    totalAmount = json['TotalAmount'];
    sectionName = json['SectionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ReservationDateFrom'] = this.reservationDateFrom;
    data['ReservationDateTo'] = this.reservationDateTo;
    data['PeriodName'] = this.periodName;
    data['BookingName'] = this.bookingName;
    data['StatusName'] = this.statusName;
    data['Approved'] = this.approved;
    data['PaidTypeName'] = this.paidTypeName;
    data['TotalAmount'] = this.totalAmount;
    data['SectionName'] = this.sectionName;
    return data;
  }
}