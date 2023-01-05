import 'package:in_app_purchase/in_app_purchase.dart';

class LastSeenProduct {
  String? sku;
  int? trackHour;
  bool isDemo = false;
  String? name;
  String? line1;
  bool? is_inapp;

  LastSeenProduct(
      {this.sku, this.trackHour, required this.isDemo, this.name, this.line1});

  LastSeenProduct.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    trackHour = json['track_hour'];
    isDemo = json['is_demo'];
    name = json['name'];
    line1 = json['line_1'];
    is_inapp = json['is_inapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['track_hour'] = this.trackHour;
    data['is_demo'] = this.isDemo;
    data['name'] = this.name;
    data['line_1'] = this.line1;
    data['is_inapp'] = this.is_inapp;
    return data;
  }
}

class ApiGoogleProduct {
  String? sku;
  int? trackHour;
  bool isDemo = false;
  String? name;
  String? line1;
  bool? is_inapp;
  ProductDetails? productDetails;

  ApiGoogleProduct(
      {this.sku,
      this.trackHour,
      required this.isDemo,
      this.name,
      this.line1,
      this.is_inapp,
      this.productDetails});

  ApiGoogleProduct.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    trackHour = json['track_hour'];
    isDemo = json['is_demo'];
    name = json['name'];
    line1 = json['line_1'];
    is_inapp = json['is_inapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['track_hour'] = this.trackHour;
    data['is_demo'] = this.isDemo;
    data['name'] = this.name;
    data['line_1'] = this.line1;
    data['is_inapp'] = this.is_inapp;
    return data;
  }
}
