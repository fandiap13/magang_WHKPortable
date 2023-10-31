class ResponseSensor {
  late int duration;
  late String startAt;
  late String endAt;
  late bool error;
  late String status;
  late String value;
  late String sId;

  ResponseSensor(
      {required this.duration,
      required this.startAt,
      required this.endAt,
      required this.error,
      required this.status,
      required this.value,
      required this.sId});

  ResponseSensor.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    error = json['error'];
    status = json['status'];
    value = json['value'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duration'] = duration;
    data['start_at'] = startAt;
    data['end_at'] = endAt;
    data['error'] = error;
    data['status'] = status;
    data['value'] = value;
    data['_id'] = sId;
    return data;
  }
}
