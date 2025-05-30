class ListFavoris {
  int? id;
  String? residenceCode;
  String? residenceMainPhoto;
  String? residenceType;
  String? residenceOwner;
  String? residenceOwnerContact;
  String? residenceOwnerAddress;
  String? residenceStreet;
  int? residenceBathrooms;
  double? residenceLatitude;
  double? residenceLongitude;
  int? residencePrice;
  int? personsSupported;
  int? residenceBeds;
  int? residenceRooms;

  ListFavoris({
    this.id,
    this.residenceCode,
    this.residenceMainPhoto,
    this.residenceType,
    this.residenceOwner,
    this.residenceOwnerContact,
    this.residenceOwnerAddress,
    this.residenceStreet,
    this.residenceBathrooms,
    this.residenceLatitude,
    this.residenceLongitude,
    this.residencePrice,
    this.personsSupported,
    this.residenceBeds,
    this.residenceRooms,
  });

  ListFavoris.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    residenceCode = json['residence_code'];
    residenceMainPhoto = json['residence_main_photo'];
    residenceType = json['residence_type'];
    residenceOwner = json['residence_owner'];
    residenceOwnerContact = json['residence_owner_contact'];
    residenceOwnerAddress = json['residence_owner_address'];
    residenceStreet = json['residence_street'];
    residenceBathrooms = json['residence_bathrooms'];
    residenceLatitude = json['residence_latitude'];
    residenceLongitude = json['residence_longitude'];
    residencePrice = json['residence_price'];
    personsSupported = json['persons_supported'];
    residenceBeds = json['residence_beds'];
    residenceRooms = json['residence_rooms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['residence_code'] = residenceCode;
    data['residence_main_photo'] = residenceMainPhoto;
    data['residence_type'] = residenceType;
    data['residence_owner'] = residenceOwner;
    data['residence_owner_contact'] = residenceOwnerContact;
    data['residence_owner_address'] = residenceOwnerAddress;
    data['residence_street'] = residenceStreet;
    data['residence_bathrooms'] = residenceBathrooms;
    data['residence_latitude'] = residenceLatitude;
    data['residence_longitude'] = residenceLongitude;
    data['residence_price'] = residencePrice;
    data['persons_supported'] = personsSupported;
    data['residence_beds'] = residenceBeds;
    data['residence_rooms'] = residenceRooms;
    return data;
  }
}
