class DetailMachineData {
  final List<DetailMachine> morning;
  final List<DetailMachine> afternoon;
  final List<DetailMachine> night;

  DetailMachineData({
    required this.morning,
    required this.afternoon,
    required this.night,
  });

  factory DetailMachineData.fromJson(Map<String, dynamic> json) {
    return DetailMachineData(
      morning: (json['morning'] as List<dynamic>)
          .map((e) => DetailMachine.fromJson(e))
          .toList(),
      afternoon: (json['afternoon'] as List<dynamic>)
          .map((e) => DetailMachine.fromJson(e))
          .toList(),
      night: (json['night'] as List<dynamic>)
          .map((e) => DetailMachine.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'morning': morning.map((e) => e.toJson()).toList(),
      'afternoon': afternoon.map((e) => e.toJson()).toList(),
      'night': night.map((e) => e.toJson()).toList(),
    };
  }
}

class DetailMachine {
  final String time;
  final bool isAvailable;

  DetailMachine({
    required this.time,
    required this.isAvailable,
  });

  factory DetailMachine.fromJson(Map<String, dynamic> json) {
    return DetailMachine(
      time: json['time'] as String,
      isAvailable: json['is_available'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'time': time, 'is_available': isAvailable};
  }
}
