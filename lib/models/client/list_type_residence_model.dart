class ListResidenceModel {
  String? id;
  String? name;
  String? image;

  ListResidenceModel({
    this.id,
    this.name,
    this.image,
  });

  ListResidenceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
