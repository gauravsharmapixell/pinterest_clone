import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/pin_entity.dart';
import '../providers/home_providers.dart';

final homeRefreshTriggerProvider = StateProvider<int>((ref) => 0);

final homePinsProvider = FutureProvider<List<PinEntity>>((ref) async {
  ref.watch(homeRefreshTriggerProvider);
  final getPinsUseCase = ref.watch(getPinsUseCaseProvider);
  return getPinsUseCase();
});
