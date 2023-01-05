class AddNumber {
  int? id;
  int? notification;
  int? status;
  String? statusDesc;
  String? name;
  String? countryCode;
  String? number;
  bool? isTracking;
  Product? product;
  List<Events>? events;

  AddNumber(
      {this.id,
      this.notification,
      this.status,
      this.statusDesc,
      this.name,
      this.countryCode,
      this.number,
      this.isTracking,
      this.product,
      this.events});

  AddNumber.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notification = json['notification'];
    status = json['status'];
    statusDesc = json['status_desc'];
    name = json['name'];
    countryCode = json['country_code'];
    number = json['number'];
    isTracking = json['is_tracking'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notification'] = this.notification;
    data['status'] = this.status;
    data['status_desc'] = this.statusDesc;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['number'] = this.number;
    data['is_tracking'] = this.isTracking;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? sku;
  String? name;

  Product({this.sku, this.name});

  Product.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['name'] = this.name;
    return data;
  }
}

class Events {
  String? onlineHour;
  String? offlineHour;
  String? duraction;
  String? onlineDate;
  String? offlineDate;

  Events(
      {this.onlineHour,
      this.offlineHour,
      this.duraction,
      this.onlineDate,
      this.offlineDate});

  Events.fromJson(Map<String, dynamic> json) {
    onlineHour = json['online_hour'];
    offlineHour = json['offline_hour'];
    duraction = json['duraction'];
    onlineDate = json['online_date'];
    offlineDate = json['offline_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['online_hour'] = this.onlineHour;
    data['offline_hour'] = this.offlineHour;
    data['duraction'] = this.duraction;
    data['online_date'] = this.onlineDate;
    data['offline_date'] = this.offlineDate;
    return data;
  }
}
