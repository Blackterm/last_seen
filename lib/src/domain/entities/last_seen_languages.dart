class LastSeenLanguages {
  int? id;
  String? name;
  String? code;
  String? translate;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  LastSeenLanguages(
      {this.id,
      this.name,
      this.code,
      this.translate,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  LastSeenLanguages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    translate = json['translate'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['translate'] = this.translate;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
