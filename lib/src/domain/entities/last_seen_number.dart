class LastSeenNumber {
  int? id;
  bool? notification;
  int? status;
  String? statusDesc;
  bool? isFavorite;
  String? name;
  String? countryCode;
  String? number;
  bool? isTracking;
  Product? product;
  bool? is_online;
  List<Events>? events;
  List<Graphics>? graphics;
  List<DailyEvents>? dailyEvents;
  List<WeeklyEvents>? weeklyEvents;

  LastSeenNumber(
      {this.id,
      this.notification,
      this.status,
      this.statusDesc,
      this.isFavorite,
      this.name,
      this.countryCode,
      this.number,
      this.isTracking,
      this.is_online,
      this.product,
      this.events,
      this.graphics,
      this.dailyEvents,
      this.weeklyEvents});

  LastSeenNumber.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notification = json['notification'];
    status = json['status'];
    statusDesc = json['status_desc'];
    isFavorite = json['is_favorite'];
    name = json['name'];
    countryCode = json['country_code'];
    number = json['number'];
    isTracking = json['is_tracking'];
    is_online = json['is_online'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
    if (json['graphics'] != null) {
      graphics = <Graphics>[];
      json['graphics'].forEach((v) {
        graphics!.add(new Graphics.fromJson(v));
      });
    }
    if (json['daily_events'] != null) {
      dailyEvents = <DailyEvents>[];
      json['daily_events'].forEach((v) {
        dailyEvents!.add(new DailyEvents.fromJson(v));
      });
    }
    if (json['weekly_events'] != null) {
      weeklyEvents = <WeeklyEvents>[];
      json['weekly_events'].forEach((v) {
        weeklyEvents!.add(new WeeklyEvents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notification'] = this.notification;
    data['status'] = this.status;
    data['status_desc'] = this.statusDesc;
    data['is_favorite'] = this.isFavorite;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['number'] = this.number;
    data['is_tracking'] = this.isTracking;
    data['is_online'] = this.is_online;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    if (this.graphics != null) {
      data['graphics'] = this.graphics!.map((v) => v.toJson()).toList();
    }
    if (this.dailyEvents != null) {
      data['daily_events'] = this.dailyEvents!.map((v) => v.toJson()).toList();
    }
    if (this.weeklyEvents != null) {
      data['weekly_events'] =
          this.weeklyEvents!.map((v) => v.toJson()).toList();
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

class Graphics {
  String? hour;
  int? count;
  String? duraction;

  Graphics({this.hour, this.count, this.duraction});

  Graphics.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    count = json['count'];
    duraction = json['duraction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['count'] = this.count;
    data['duraction'] = this.duraction;
    return data;
  }
}

class DailyEvents {
  String? day;
  List<Events>? events;

  DailyEvents({this.day, this.events});

  DailyEvents.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WeeklyEvents {
  String? startDay;
  List<Events>? events;

  WeeklyEvents({this.startDay, this.events});

  WeeklyEvents.fromJson(Map<String, dynamic> json) {
    startDay = json['start_day'];
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_day'] = this.startDay;
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
