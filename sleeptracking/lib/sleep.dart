class SleepData {
  final DateTime startTime;
  final DateTime endTime;

  SleepData(this.startTime, this.endTime);

  Duration get sleepDuration => endTime.difference(startTime);

  Map<String, dynamic> toJson() => {
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
      };

  factory SleepData.fromJson(Map<String, dynamic> json) {
    return SleepData(
      DateTime.parse(json['startTime']),
      DateTime.parse(json['endTime']),
    );
  }
}
