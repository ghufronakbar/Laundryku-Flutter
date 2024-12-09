class DetailReservation {
  final String id;
  final String title;
  final String status;
  final int paymentTotal;
  final String snapToken;
  final String directUrl;
  final String? paymentMethod;
  final String reservationDate;
  final String reservationEnd;
  final String? paidAt;
  final String createdAt;
  final String customStatus;

  DetailReservation({
    required this.id,
    required this.title,
    required this.status,
    required this.paymentTotal,
    required this.snapToken,
    required this.directUrl,
    this.paymentMethod,
    required this.reservationDate,
    required this.reservationEnd,
    this.paidAt,
    required this.createdAt,
    required this.customStatus,
  });

  factory DetailReservation.fromJson(Map<String, dynamic> json) {
    return DetailReservation(
      id: json['id'],
      title: json['title'],
      status: json['status'],
      paymentTotal: json['payment_total'],
      snapToken: json['snap_token'],
      directUrl: json['direct_url'],
      paymentMethod: json['payment_method'],
      reservationDate: json['reservation_date'],
      reservationEnd: json['reservation_end'],
      paidAt: json['paid_at'],
      createdAt: json['created_at'],
      customStatus: json['custom_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'payment_total': paymentTotal,
      'snap_token': snapToken,
      'direct_url': directUrl,
      'payment_method': paymentMethod,
      'reservation_date': reservationDate,
      'reservation_end': reservationEnd,
      'paid_at': paidAt,
      'created_at': createdAt,
      'custom_status': customStatus
    };
  }
}
