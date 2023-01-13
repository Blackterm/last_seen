class DeviceConnections {
  int? id;
  String? name;
  String? uuid;
  int? status;
  String? statusDesc;
  String? url;

  DeviceConnections(
      {this.id, this.name, this.uuid, this.status, this.statusDesc, this.url});

  DeviceConnections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    uuid = json['uuid'];
    status = json['status'];
    statusDesc = json['status_desc'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['uuid'] = this.uuid;
    data['status'] = this.status;
    data['status_desc'] = this.statusDesc;
    data['url'] = this.url;
    return data;
  }
}
