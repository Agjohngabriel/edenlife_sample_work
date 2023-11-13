import 'package:dio/dio.dart';

import '../../../models/api_responses.dart';


class ApiUtils {
// for responses and errors returned from the server
  static ApiResponse toApiResponse(Response res) {
    return ApiResponse(
      statusCode: res.data['statusCode'],
      message: res.data['message'],
      data: res.data['data'],
    );
  }

// for errors not returned from the server
  static ApiResponse genericError(
      {required String message,
        required bool isSuccessful,
        required int statusCode,
        dynamic data}) {
    return ApiResponse(
      statusCode: statusCode,
      data: null,
      message: message,
    );
  }
}
