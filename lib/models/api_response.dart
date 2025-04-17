class ApiResponse<T> {
  final int statusCode;
  final String message;
  final T? data;

  ApiResponse({required this.statusCode, required this.message, this.data});

  // Factory constructor to create an ApiResponse from JSON
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return ApiResponse<T>(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  // Method to convert ApiResponse to JSON
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': data != null ? toJsonT(data!) : null,
    };
  }
}
