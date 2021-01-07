import 'dart:io' as io;

import 'package:dio/dio.dart';

class NetworkClient {
  final Dio _dio;

  NetworkClient(this._dio) : assert(_dio != null);

  void download(
    String url,
    String savePath, {
    void Function(int, int) onReceiveProgress,
  }) async {
    final file = io.File(savePath);
    try {
      await file.create();

      await _dio.download(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
      );
    } on Exception {
      return;
    }
  }
}
