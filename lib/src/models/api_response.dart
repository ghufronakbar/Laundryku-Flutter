class ApiResponse<T> {
  final int status;
  final String message;
  final T data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return ApiResponse(
      status: json['status'],
      message: json['message'],
      data: fromJsonT(json['data']),
    );
  }
}
