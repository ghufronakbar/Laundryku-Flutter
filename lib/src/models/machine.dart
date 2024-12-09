class MachineData {
  final List<Machine> washingMachines;
  final List<Machine> dryingMachines;

  MachineData({
    required this.washingMachines,
    required this.dryingMachines,
  });

  factory MachineData.fromJson(Map<String, dynamic> json) {
    return MachineData(
      washingMachines: (json['washing_machines'] as List<dynamic>)
          .map((e) => Machine.fromJson(e))
          .toList(),
      dryingMachines: (json['drying_machines'] as List<dynamic>)
          .map((e) => Machine.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'washing_machines': washingMachines.map((e) => e.toJson()).toList(),
      'drying_machines': dryingMachines.map((e) => e.toJson()).toList(),
    };
  }
}

class Machine {
  final String name;
  final bool isAvailable;

  Machine({
    required this.name,
    required this.isAvailable,
  });

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      name: json['name'] as String,
      isAvailable: json['is_available'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'is_available': isAvailable};
  }
}
