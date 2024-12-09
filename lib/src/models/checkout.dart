class Checkout {
  final String id;
  final String machineId;
  final String machineNumber;
  final DateTime reservationDate;
  final DateTime reservationEnd;
  final String status;
  final String userId;
  final int total;
  final DateTime updatedAt;
  final DateTime createdAt;

  Checkout({
    required this.id,
    required this.machineId,
    required this.machineNumber,
    required this.reservationDate,
    required this.reservationEnd,
    required this.status,
    required this.userId,
    required this.total,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Checkout.fromJson(Map<String, dynamic> json) {
    return Checkout(
      id: json['id'],
      machineId: json['machine_id'],
      machineNumber: json['machine_number'],
      reservationDate: DateTime.parse(json['reservation_date']),
      reservationEnd: DateTime.parse(json['reservation_end']),
      status: json['status'],
      userId: json['user_id'],
      total: json['total'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'machine_id': machineId,
      'machine_number': machineNumber,
      'reservation_date': reservationDate.toIso8601String(),
      'reservation_end': reservationEnd.toIso8601String(),
      'status': status,
      'user_id': userId,
      'total': total,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
