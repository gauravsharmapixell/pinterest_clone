import '../../domain/entities/pin_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this.remoteDataSource);

  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<List<PinEntity>> getPins() {
    return remoteDataSource.getPins();
  }
}
