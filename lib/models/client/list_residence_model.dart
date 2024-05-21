class ResidenceClient {
  String? id;
  String? createdAt;
  String? code;
  String? district;
  String? address;
  double? latitude;
  double? longitude;
  String? description;
  int? price;
  int? personsSupported;
  int? rooms;
  int? beds;
  int? bathrooms;
  String? disponibility;
  String? availableAt;
  String? availableUntil;
  String? mainPhoto;
  List<String>? photos;
  String? category;
  String? country;
  String? city;
  List<Equipments>? equipments;

  ResidenceClient({
    this.id,
    this.createdAt,
    this.code,
    this.district,
    this.address,
    this.latitude,
    this.longitude,
    this.description,
    this.price,
    this.personsSupported,
    this.rooms,
    this.beds,
    this.bathrooms,
    this.disponibility,
    this.availableAt,
    this.availableUntil,
    this.mainPhoto,
    this.photos,
    this.category,
    this.country,
    this.city,
    this.equipments,
  });

  ResidenceClient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    code = json['code'];
    district = json['district'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    description = json['description'];
    price = json['price'];
    personsSupported = json['persons_supported'];
    rooms = json['rooms'];
    beds = json['beds'];
    bathrooms = json['bathrooms'];
    disponibility = json['disponibility'];
    availableAt = json['available_at'];
    availableUntil = json['available_until'];
    mainPhoto = json['main_photo'];
    photos = json['photos'].cast<String>();
    category = json['category'];
    country = json['country'];
    city = json['city'];
    if (json['equipments'] != null) {
      equipments = <Equipments>[];
      json['equipments'].forEach((v) {
        equipments!.add(Equipments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['code'] = code;
    data['district'] = district;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['description'] = description;
    data['price'] = price;
    data['persons_supported'] = personsSupported;
    data['rooms'] = rooms;
    data['beds'] = beds;
    data['bathrooms'] = bathrooms;
    data['disponibility'] = disponibility;
    data['available_at'] = availableAt;
    data['available_until'] = availableUntil;
    data['main_photo'] = mainPhoto;
    data['photos'] = photos;
    data['category'] = category;
    data['country'] = country;
    data['city'] = city;
    if (equipments != null) {
      data['equipments'] = equipments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Equipments {
  String? name;

  Equipments({this.name});

  Equipments.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
