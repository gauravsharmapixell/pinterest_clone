import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class DioClient {
  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.pexelsBaseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            headers: {
              'Authorization': ApiConstants.pexelsApiKey,
            },
          ),
        );

  final Dio dio;
}
