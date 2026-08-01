import 'dart:io';

import 'package:book_adder_2/services/a_network.dart';
import 'package:dio/dio.dart';

class FileService {
  Future<Response> updateFile(
    File file,
    String filePath, {
    String contentType = 'application/octet-stream',
    ProgressCallback? onSendProgress,
  }) async {
    final fileLength = await file.length();

    final r = await dio.put(
      '/files/${filePath.replaceAll(RegExp(r'^/+'), '')}',
      data: file.openRead(),
      options: Options(
        headers: {
          Headers.contentTypeHeader: contentType,
          Headers.contentLengthHeader: fileLength,
        },
      ),
      onSendProgress: onSendProgress,
    );

    return r;
  }

  Future<Response> createFile(
    File file, {
    String dirPath = '',
    String contentType = 'application/octet-stream',
    ProgressCallback? onSendProgress,
  }) async {
    final fileLength = await file.length();

    final normalizedDirPath = dirPath.replaceAll(RegExp(r'^/+|/+$'), '');

    final endpoint = normalizedDirPath.isEmpty
        ? '/files/'
        : '/files/$normalizedDirPath';

    final r = await dio.post(
      endpoint,
      data: file.openRead(),
      options: Options(
        headers: {
          Headers.contentTypeHeader: contentType,
          Headers.contentLengthHeader: fileLength,
        },
      ),
      onSendProgress: onSendProgress,
    );

    return r;
  }
}
