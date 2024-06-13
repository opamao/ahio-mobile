class StatesGains {
  String? residenceReference;
  int? price;
  int? totalDays;
  int? gainTotal;

  StatesGains({
    this.residenceReference,
    this.price,
    this.totalDays,
    this.gainTotal,
  });

  StatesGains.fromJson(Map<String, dynamic> json) {
    residenceReference = json['residence_reference'];
    price = json['price'];
    totalDays = json['total_days'];
    gainTotal = json['gain_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['residence_reference'] = residenceReference;
    data['price'] = price;
    data['total_days'] = totalDays;
    data['gain_total'] = gainTotal;
    return data;
  }
}
