class ReservationData {
  final List<Reservation> completed;
  final List<Reservation> onGoing;
  final List<Reservation> cancelled;
  final List<Reservation> unpaid;

  ReservationData({
    required this.completed,
    required this.onGoing,
    required this.cancelled,
    required this.unpaid,
  });

  factory ReservationData.fromJson(Map<String, dynamic> json) {
    return ReservationData(
      completed: (json['completed'] as List<dynamic>).map((e) => Reservation.fromJson(e)).toList(),
      onGoing: (json['on_going'] as List<dynamic>).map((e) => Reservation.fromJson(e)).toList(),
      cancelled: (json['cancelled'] as List<dynamic>).map((e) => Reservation.fromJson(e)).toList(),
      unpaid: (json['unpaid'] as List<dynamic>).map((e) => Reservation.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completed': completed.map((e) => e.toJson()).toList(),
      'on_going': onGoing.map((e) => e.toJson()).toList(),
      'cancelled': cancelled.map((e) => e.toJson()).toList(),
      'unpaid': unpaid.map((e) => e.toJson()).toList(),
    };
  }
}

class Reservation {
  final String id;
  final String status;
  final DateTime reservationDate;
  final DateTime reservationEnd;
  final String title;

  Reservation({
    required this.id,
    required this.status,
    required this.reservationDate,
    required this.reservationEnd,
    required this.title,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] as String,
      status: json['status'] as String,
      reservationDate: DateTime.parse(json['reservation_date']),
      reservationEnd: DateTime.parse(json['reservation_end']),
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'reservation_date': reservationDate,
      'reservation_end': reservationEnd,
      'title': title,
    };
  }
}
