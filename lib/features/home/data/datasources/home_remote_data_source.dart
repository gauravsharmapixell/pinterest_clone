import 'dart:math';

import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../models/pin_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<PinModel>> getPins();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(this.dio);

  final Dio dio;
  final Random _random = Random();

  @override
  Future<List<PinModel>> getPins() async {
    final page = _random.nextInt(20) + 1;

    final response = await dio.get(
      ApiConstants.curatedPinsEndpoint,
      queryParameters: {
        'page': page,
        'per_page': 20,
      },
    );

    final photos = (response.data['photos'] as List<dynamic>? ?? []);

    return photos.map((photo) {
      final item = photo as Map<String, dynamic>;
      final src = item['src'] as Map<String, dynamic>? ?? {};

      return PinModel(
        id: '${item['id']}-$page',
        title: (item['alt'] as String?)?.trim().isNotEmpty == true
            ? item['alt'] as String
            : 'Pinterest inspiration',
        imageUrl:
            (src['large'] ?? src['medium'] ?? src['original'] ?? '') as String,
        imageHeight: _calculateTileHeight(
          width: (item['width'] as num?)?.toDouble() ?? 1000,
          height: (item['height'] as num?)?.toDouble() ?? 1500,
        ),
      );
    }).toList();
  }

  double _calculateTileHeight({
    required double width,
    required double height,
  }) {
    final ratio = height / width;
    final scaledHeight = 180 * ratio;
    return scaledHeight.clamp(180, 360).toDouble();
  }
}
