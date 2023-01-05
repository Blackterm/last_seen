class EmitterNumberStatus {
  int? id;
  int? status;
  String? statusDesc;

  EmitterNumberStatus({this.id, this.status, this.statusDesc});

  EmitterNumberStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    statusDesc = json['status_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['status_desc'] = this.statusDesc;
    return data;
  }
}

class EmitterIsOnline {
  int? id;
  int? is_online;

  EmitterIsOnline({this.id, this.is_online});

  EmitterIsOnline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    is_online = json['is_online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_online'] = this.is_online;

    return data;
  }
}

class EmitterAddEvent {
  int? id;
  String? start_date;
  String? end_date;
  String? start_time;
  String? end_time;

  EmitterAddEvent({
    this.id,
    this.start_date,
    this.end_date,
    this.start_time,
    this.end_time,
  });

  EmitterAddEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start_date = json['start_date'];
    end_date = json['end_date'];
    start_time = json['start_time'];
    end_time = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.start_date;
    data['end_date'] = this.end_date;
    data['start_time'] = this.start_time;
    data['end_time'] = this.end_time;

    return data;
  }
}
