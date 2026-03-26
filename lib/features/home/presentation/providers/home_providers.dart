import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/network_providers.dart';
import '../../data/datasources/home_remote_data_source.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/get_pins_usecase.dart';

final homeRemoteDataSourceProvider = Provider<HomeRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return HomeRemoteDataSourceImpl(dio);
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final remoteDataSource = ref.watch(homeRemoteDataSourceProvider);
  return HomeRepositoryImpl(remoteDataSource);
});

final getPinsUseCaseProvider = Provider<GetPinsUseCase>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return GetPinsUseCase(repository);
});
