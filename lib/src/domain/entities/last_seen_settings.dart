class LastSeenSettings {
  String? appSku;
  int? ctaPeriod;
  String? marketUrl;
  String? privacyPolicy;
  String? termsOfUse;
  String? mail;
  int? isShowModal;
  int? isShowDemo;
  int? use_slowly;
  int? use_speedy;
  String? app_version;

  LastSeenSettings({
    this.appSku,
    this.ctaPeriod,
    this.marketUrl,
    this.privacyPolicy,
    this.termsOfUse,
    this.mail,
    this.isShowModal,
    this.isShowDemo,
    this.use_slowly,
    this.use_speedy,
    this.app_version,
  });

  LastSeenSettings.fromJson(Map<String, dynamic> json) {
    mail = json['email'];
    appSku = json['app_sku'];
    ctaPeriod = json['cta_period'];
    marketUrl = json['market_url'];
    privacyPolicy = json['privacy_policy'];
    termsOfUse = json['terms_of_use'];
    isShowModal = json['is_show_modal'];
    isShowDemo = json['is_show_demo'];
    use_slowly = json['use_slowly'];
    use_speedy = json['use_speedy'];
    app_version = json['app_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.mail;
    data['app_sku'] = this.appSku;
    data['cta_period'] = this.ctaPeriod;
    data['market_url'] = this.marketUrl;
    data['privacy_policy'] = this.privacyPolicy;
    data['terms_of_use'] = this.termsOfUse;
    data['is_show_modal'] = this.isShowModal;
    data['is_show_demo'] = this.isShowDemo;
    data['use_slowly'] = this.use_slowly;
    data['use_speedy'] = this.use_speedy;
    data['app_version'] = this.app_version;
    return data;
  }
}
