class ListReservationClient {
  String? id;
  String? startDate;
  String? endDate;
  int? persons;
  String? rating;
  String? state;
  Residence? residence;
  String? createdAt;

  ListReservationClient({
    this.id,
    this.startDate,
    this.endDate,
    this.persons,
    this.rating,
    this.state,
    this.residence,
    this.createdAt,
  });

  ListReservationClient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    persons = json['persons'];
    rating = json['rating'];
    state = json['state'];
    residence = json['residence'] != null
        ? Residence.fromJson(json['residence'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['persons'] = persons;
    data['rating'] = rating;
    data['state'] = state;
    if (residence != null) {
      data['residence'] = residence!.toJson();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class Residence {
  String? id;
  String? code;
  int? userId;
  String? residenceTypeId;
  String? district;
  String? street;
  List<String>? photos;
  String? description;
  double? latitude;
  double? longitude;
  int? personsSupported;
  int? rooms;
  int? beds;
  int? price;
  bool? disponibility;
  int? bathrooms;
  String? availableAt;
  String? availableUntil;
  String? disabledAt;
  String? deletedAt;
  String? updatedAt;
  String? verifiedAt;
  String? countryId;
  String? cityId;
  String? address;
  String? mainPhoto;

  Residence({
    this.id,
    this.code,
    this.userId,
    this.residenceTypeId,
    this.district,
    this.street,
    this.photos,
    this.description,
    this.latitude,
    this.longitude,
    this.personsSupported,
    this.rooms,
    this.beds,
    this.price,
    this.disponibility,
    this.bathrooms,
    this.availableAt,
    this.availableUntil,
    this.disabledAt,
    this.deletedAt,
    this.updatedAt,
    this.verifiedAt,
    this.countryId,
    this.cityId,
    this.address,
    this.mainPhoto,
  });

  Residence.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    userId = json['user_id'];
    residenceTypeId = json['residence_type_id'];
    district = json['district'];
    street = json['street'];
    photos = json['photos'].cast<String>();
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    personsSupported = json['persons_supported'];
    rooms = json['rooms'];
    beds = json['beds'];
    price = json['price'];
    disponibility = json['disponibility'];
    bathrooms = json['bathrooms'];
    availableAt = json['available_at'];
    availableUntil = json['available_until'];
    disabledAt = json['disabled_at'];
    deletedAt = json['deleted_at'];
    updatedAt = json['updated_at'];
    verifiedAt = json['verified_at'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    address = json['address'];
    mainPhoto = json['main_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['user_id'] = userId;
    data['residence_type_id'] = residenceTypeId;
    data['district'] = district;
    data['street'] = street;
    data['photos'] = photos;
    data['description'] = description;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['persons_supported'] = personsSupported;
    data['rooms'] = rooms;
    data['beds'] = beds;
    data['price'] = price;
    data['disponibility'] = disponibility;
    data['bathrooms'] = bathrooms;
    data['available_at'] = availableAt;
    data['available_until'] = availableUntil;
    data['disabled_at'] = disabledAt;
    data['deleted_at'] = deletedAt;
    data['updated_at'] = updatedAt;
    data['verified_at'] = verifiedAt;
    data['country_id'] = countryId;
    data['city_id'] = cityId;
    data['address'] = address;
    data['main_photo'] = mainPhoto;
    return data;
  }
}
