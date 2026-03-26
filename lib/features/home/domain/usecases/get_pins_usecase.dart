import '../entities/pin_entity.dart';
import '../repositories/home_repository.dart';

class GetPinsUseCase {
  const GetPinsUseCase(this.repository);

  final HomeRepository repository;

  Future<List<PinEntity>> call() {
    return repository.getPins();
  }
}
