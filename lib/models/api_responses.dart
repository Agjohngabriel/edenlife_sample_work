class ApiResponse {
  dynamic data;
  String? message;
  int? statusCode;

  ApiResponse(
      {this.data,
        required this.message,
        required this.statusCode});

  @override
  String toString() {
    return 'ApiResponse(data: $data,message: $message,statusCode: $statusCode,)';
  }
}
