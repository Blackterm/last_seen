class LangaugeRegister {
  String? uuid;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? timezone;
  String? locale;
  String? version;
  late bool? useDemo;
  Translations? translations;

  LangaugeRegister(
      {this.uuid,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.timezone,
      this.locale,
      this.version,
      this.useDemo,
      this.translations});

  LangaugeRegister.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    timezone = json['timezone'];
    locale = json['locale'];
    version = json['version'];
    useDemo = json['use_demo'];
    translations = json['translations'] != null
        ? new Translations.fromJson(json['translations'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['timezone'] = this.timezone;
    data['locale'] = this.locale;
    data['version'] = this.version;
    data['use_demo'] = this.useDemo;
    if (this.translations != null) {
      data['translations'] = this.translations!.toJson();
    }
    return data;
  }
}

class Translations {
  TrTR? trTR;
  TrTR? enUS;

  Translations({this.trTR, this.enUS});

  Translations.fromJson(Map<String, dynamic> json) {
    trTR = json['tr_TR'] != null ? new TrTR.fromJson(json['tr_TR']) : null;
    enUS = json['en_US'] != null ? new TrTR.fromJson(json['en_US']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trTR != null) {
      data['tr_TR'] = this.trTR!.toJson();
    }
    if (this.enUS != null) {
      data['en_US'] = this.enUS!.toJson();
    }
    return data;
  }
}

class TrTR {
  String? locale;
  String? language;
  Language? languages;
  String? addPhoneNullFieldError;
  String? addPhoneLimitError;
  String? tryFree;
  String? freeTrialTitle;
  String? freeTrialLabel1;
  String? freeTrialLabel2;
  String? freeTrialLabel3;
  String? freeTrialTryButton;
  String? freeTrialCaption;
  String? close;
  String? pricesOptionsTitle;
  String? contin;
  String? pricesOptionsCaption;
  String? activities;
  String? emailSupportSubject;
  String? emailSupportBody;
  String? support;
  String? termsofuse;
  String? privacypolicy;
  String? rateus;
  String? premiumBenefits;
  String? generalSettings;
  String? email;
  String? premium;
  String? addNumber;
  String? switchPro;
  String? procesing;
  String? onHold;
  String? nullActivityText;
  String? nullActivityCaption;
  String? activeTime;
  String? second;
  String? onlineTime;
  String? activeNumber;
  String? daily;
  String? weekly;
  String? successful;
  String? successfulAddNumberCaption;
  String? okay;
  String? unsuccessful;
  String? unsuccessfulCaption;
  String? numberSettings;
  String? namedNumber;
  String? onlineNotification;
  String? removeNumber;
  String? removeNumberCaption;
  String? newPhoneCaption;
  String? startTracking;
  String? trackingPolicy;
  String? filter;
  String? changeLang;

  TrTR(
      {this.locale,
      this.language,
      this.languages,
      this.addPhoneNullFieldError,
      this.addPhoneLimitError,
      this.tryFree,
      this.freeTrialTitle,
      this.freeTrialLabel1,
      this.freeTrialLabel2,
      this.freeTrialLabel3,
      this.freeTrialTryButton,
      this.freeTrialCaption,
      this.close,
      this.pricesOptionsTitle,
      this.contin,
      this.pricesOptionsCaption,
      this.activities,
      this.emailSupportSubject,
      this.emailSupportBody,
      this.support,
      this.termsofuse,
      this.privacypolicy,
      this.rateus,
      this.premiumBenefits,
      this.generalSettings,
      this.email,
      this.premium,
      this.addNumber,
      this.switchPro,
      this.procesing,
      this.onHold,
      this.nullActivityText,
      this.nullActivityCaption,
      this.activeTime,
      this.second,
      this.onlineTime,
      this.activeNumber,
      this.daily,
      this.weekly,
      this.successful,
      this.successfulAddNumberCaption,
      this.okay,
      this.unsuccessful,
      this.unsuccessfulCaption,
      this.numberSettings,
      this.namedNumber,
      this.onlineNotification,
      this.removeNumber,
      this.removeNumberCaption,
      this.newPhoneCaption,
      this.startTracking,
      this.trackingPolicy,
      this.filter,
      this.changeLang});

  TrTR.fromJson(Map<String, dynamic> json) {
    locale = json['@@locale'];
    language = json['language'];
    languages = json['@language'] != null
        ? new Language.fromJson(json['@language'])
        : null;
    addPhoneNullFieldError = json['addPhoneNullFieldError'];
    addPhoneLimitError = json['addPhoneLimitError'];
    tryFree = json['tryFree'];
    freeTrialTitle = json['freeTrialTitle'];
    freeTrialLabel1 = json['freeTrialLabel1'];
    freeTrialLabel2 = json['freeTrialLabel2'];
    freeTrialLabel3 = json['freeTrialLabel3'];
    freeTrialTryButton = json['freeTrialTryButton'];
    freeTrialCaption = json['freeTrialCaption'];
    close = json['close'];
    pricesOptionsTitle = json['pricesOptionsTitle'];
    contin = json['contin'];
    pricesOptionsCaption = json['pricesOptionsCaption'];
    activities = json['activities'];
    emailSupportSubject = json['emailSupportSubject'];
    emailSupportBody = json['emailSupportBody'];
    support = json['support'];
    termsofuse = json['termsofuse'];
    privacypolicy = json['privacypolicy'];
    rateus = json['rateus'];
    premiumBenefits = json['premiumBenefits'];
    generalSettings = json['generalSettings'];
    email = json['email'];
    premium = json['premium'];
    addNumber = json['addNumber'];
    switchPro = json['switchPro'];
    procesing = json['procesing'];
    onHold = json['onHold'];
    nullActivityText = json['nullActivityText'];
    nullActivityCaption = json['nullActivityCaption'];
    activeTime = json['activeTime'];
    second = json['second'];
    onlineTime = json['onlineTime'];
    activeNumber = json['activeNumber'];
    daily = json['daily'];
    weekly = json['weekly'];
    successful = json['successful'];
    successfulAddNumberCaption = json['successfulAddNumberCaption'];
    okay = json['okay'];
    unsuccessful = json['unsuccessful'];
    unsuccessfulCaption = json['unsuccessfulCaption'];
    numberSettings = json['numberSettings'];
    namedNumber = json['namedNumber'];
    onlineNotification = json['onlineNotification'];
    removeNumber = json['removeNumber'];
    removeNumberCaption = json['removeNumberCaption'];
    newPhoneCaption = json['newPhoneCaption'];
    startTracking = json['startTracking'];
    trackingPolicy = json['trackingPolicy'];
    filter = json['filter'];
    changeLang = json['changeLang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@@locale'] = this.locale;
    data['language'] = this.language;
    if (this.languages != null) {
      data['@language'] = this.languages!.toJson();
    }
    data['addPhoneNullFieldError'] = this.addPhoneNullFieldError;
    data['addPhoneLimitError'] = this.addPhoneLimitError;
    data['tryFree'] = this.tryFree;
    data['freeTrialTitle'] = this.freeTrialTitle;
    data['freeTrialLabel1'] = this.freeTrialLabel1;
    data['freeTrialLabel2'] = this.freeTrialLabel2;
    data['freeTrialLabel3'] = this.freeTrialLabel3;
    data['freeTrialTryButton'] = this.freeTrialTryButton;
    data['freeTrialCaption'] = this.freeTrialCaption;
    data['close'] = this.close;
    data['pricesOptionsTitle'] = this.pricesOptionsTitle;
    data['contin'] = this.contin;
    data['pricesOptionsCaption'] = this.pricesOptionsCaption;
    data['activities'] = this.activities;
    data['emailSupportSubject'] = this.emailSupportSubject;
    data['emailSupportBody'] = this.emailSupportBody;
    data['support'] = this.support;
    data['termsofuse'] = this.termsofuse;
    data['privacypolicy'] = this.privacypolicy;
    data['rateus'] = this.rateus;
    data['premiumBenefits'] = this.premiumBenefits;
    data['generalSettings'] = this.generalSettings;
    data['email'] = this.email;
    data['premium'] = this.premium;
    data['addNumber'] = this.addNumber;
    data['switchPro'] = this.switchPro;
    data['procesing'] = this.procesing;
    data['onHold'] = this.onHold;
    data['nullActivityText'] = this.nullActivityText;
    data['nullActivityCaption'] = this.nullActivityCaption;
    data['activeTime'] = this.activeTime;
    data['second'] = this.second;
    data['onlineTime'] = this.onlineTime;
    data['activeNumber'] = this.activeNumber;
    data['daily'] = this.daily;
    data['weekly'] = this.weekly;
    data['successful'] = this.successful;
    data['successfulAddNumberCaption'] = this.successfulAddNumberCaption;
    data['okay'] = this.okay;
    data['unsuccessful'] = this.unsuccessful;
    data['unsuccessfulCaption'] = this.unsuccessfulCaption;
    data['numberSettings'] = this.numberSettings;
    data['namedNumber'] = this.namedNumber;
    data['onlineNotification'] = this.onlineNotification;
    data['removeNumber'] = this.removeNumber;
    data['removeNumberCaption'] = this.removeNumberCaption;
    data['newPhoneCaption'] = this.newPhoneCaption;
    data['startTracking'] = this.startTracking;
    data['trackingPolicy'] = this.trackingPolicy;
    data['filter'] = this.filter;
    data['changeLang'] = this.changeLang;
    return data;
  }
}

class Language {
  String? description;

  Language({this.description});

  Language.fromJson(Map<String, dynamic> json) {
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    return data;
  }
}
