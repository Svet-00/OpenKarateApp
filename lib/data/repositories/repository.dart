import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/exceptions/server_exceptions.dart';

abstract class Repository {
  Repository();
  @protected
  ServerException convertError(DioError error) {
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
        return ServerException(
            errno: 0, title: 'Connection timeout', detail: '');
      case DioErrorType.RESPONSE:
        var ex;
        try {
          final responseMap = error.response.data as Map<String, dynamic>;
          ex = ServerException.fromJson(responseMap);
        } catch (_) {
          ex = ServerException(
              errno: 0, title: error.message ?? 'Unknown error', detail: '');
        }
        return ex;
      case DioErrorType.CANCEL:
        return ServerException(errno: 0, title: 'Request canceled', detail: '');
      case DioErrorType.DEFAULT:
      default:
        return ServerException(errno: 0, title: error.message, detail: '');
    }
  }
}
