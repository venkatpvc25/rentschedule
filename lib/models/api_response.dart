class ApiResponse<T> {
  final int? statusCode;
  final String? message;
  final T? data;
  final String? error;

  ApiResponse({this.statusCode, this.message, this.data, this.error});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return ApiResponse<T>(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      error: json['error'],
    );
  }

  bool get hasError => error != null;

  factory ApiResponse.error(String message) => ApiResponse(error: message);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': data != null ? toJsonT(data!) : null,
    };
  }
}
