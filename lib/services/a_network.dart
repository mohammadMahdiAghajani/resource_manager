import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://localhost:8000/api/v1',
    receiveDataWhenStatusError: true,
    validateStatus: (status) => true,
  ),
);
