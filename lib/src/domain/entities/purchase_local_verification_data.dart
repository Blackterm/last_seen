class PurchaseLocalVerificationData {
  String? orderId;
  String? packageName;
  String? productId;
  int? purchaseTime;
  int? purchaseState;
  String? purchaseToken;
  int? quantity;
  bool? acknowledged;

  PurchaseLocalVerificationData(
      {this.orderId,
      this.packageName,
      this.productId,
      this.purchaseTime,
      this.purchaseState,
      this.purchaseToken,
      this.quantity,
      this.acknowledged});

  PurchaseLocalVerificationData.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    packageName = json['packageName'];
    productId = json['productId'];
    purchaseTime = json['purchaseTime'];
    purchaseState = json['purchaseState'];
    purchaseToken = json['purchaseToken'];
    quantity = json['quantity'];
    acknowledged = json['acknowledged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['packageName'] = this.packageName;
    data['productId'] = this.productId;
    data['purchaseTime'] = this.purchaseTime;
    data['purchaseState'] = this.purchaseState;
    data['purchaseToken'] = this.purchaseToken;
    data['quantity'] = this.quantity;
    data['acknowledged'] = this.acknowledged;
    return data;
  }
}



// CountryDetails details = CountryCodes.detailsForLocale();