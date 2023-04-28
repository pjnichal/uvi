class Detail {
  String? fromDate;
  String? toDate;
  String? validatingParameter;
  int? isTicket;
  int? isValidated;
  Detail(
      {this.fromDate,
      this.toDate,
      this.validatingParameter,
      this.isTicket,
      this.isValidated});

  Detail.fromJson(Map<String, dynamic> json) {
    fromDate = json['from_date'];
    toDate = json['to_date'];
    validatingParameter = json['validating_parameter'];
    isTicket = json['is_ticket'];
    isValidated = json['is_validated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['validating_parameter'] = this.validatingParameter;
    data['is_ticket'] = this.isTicket;
    data['is_validated'] = this.isValidated;
    return data;
  }
}
