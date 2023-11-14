import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

import '../../helpers/constants/api_endpoints.dart';
import '../../helpers/utils/api_utils/api_utils.dart';
import '../../models/api_responses.dart';

class ApiClient {
  static final _dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(minutes: 4),
      receiveTimeout: const Duration(minutes: 4),
    ),
  );

  static final _defaultHeader = {
    'Content-Type': 'application/json',
  };

  static String get _token => _getToken();
  static Future<ApiResponse> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool useToken = true,
  }) async {
    final result = await _makeRequest(
      () async {
        final header = _defaultHeader;
        if (useToken) {
          header.addAll(
            {'Authorization': 'Bearer $_token'},
          );
        }
        final options = Options(headers: header);
        final response = await _dio.get(endpoint,
            queryParameters: queryParameters, options: options);
        return ApiUtils.toApiResponse(response);
      },
    );
    return result;
  }

  static Future<ApiResponse> post(
    String endpoint, {
    required dynamic body,
    bool useToken = true,
  }) async {
    final result = await _makeRequest(
      () async {
        final header = _defaultHeader;
        final options = Options(headers: header);
        if (useToken) {
          header.addAll(
            {'Authorization': 'Bearer $_token'},
          );
        }
        final response =
            await _dio.post(endpoint, data: body, options: options);
        return ApiUtils.toApiResponse(response);
      },
    );
    return result;
  }

  static Future<ApiResponse> _makeRequest(Function request) async {
    try {
      final result = await request();
      return result;
    } on DioError catch (e, stack) {
      _handleDioError(e);
      return ApiUtils.toApiResponse(e.response!);
    } on SocketException catch (e) {
      _handleSocketException(e);
      return ApiUtils.genericError(
          message: e.message, isSuccessful: false, statusCode: e.port!);
    } catch (e) {
      return ApiUtils.genericError(
          message: e.toString(), isSuccessful: false, statusCode: 322);
    }
  }

  static void _handleDioError(DioError e) {
    if (e.response?.statusCode == 400) {
    } else if (e.response?.statusCode == 403) {
      //TODO::Replace this with an Actual logic
      OneContext.instance.showDialog(
          builder: (BuildContext context) => const Text("an Error Occured"));
    } else if (e.response?.statusCode == 404) {
    } else if (e.response?.statusCode == 500) {}

    inspect(e.response);
  }

  static void _handleSocketException(SocketException e) {
    debugPrint('Check Internet');
  }

  static String _getToken() {
    return "";
  }
}
