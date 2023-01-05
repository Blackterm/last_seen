class UserPurchaseDetail {
  String? error;
  String? pendingCompletePurchase;
  String? productID;
  String? purchaseID;
  String? status;
  String? transactionDate;
  String? localVerificationData;
  String? serverVerificationData;
  String? source;

  UserPurchaseDetail({
    this.error,
    this.pendingCompletePurchase,
    this.productID,
    this.purchaseID,
    this.status,
    this.transactionDate,
    this.localVerificationData,
    this.serverVerificationData,
    this.source,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['pendingCompletePurchase'] = this.pendingCompletePurchase;
    data['productID'] = this.productID;
    data['purchaseID'] = this.purchaseID;
    data['status'] = this.status;
    data['transactionDate'] = this.transactionDate;
    data['localVerificationData'] = this.localVerificationData;
    data['serverVerificationData'] = this.serverVerificationData;
    data['source'] = this.source;
    return data;
  }
}
