import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/auth_gate_screen.dart';
import '../../features/auth/presentation/screens/clerk_auth_screen.dart';
import '../../features/home/domain/entities/pin_entity.dart';
import '../../features/home/presentation/screens/pin_detail_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'root',
        builder: (context, state) => const AuthGateScreen(),
      ),
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) {
          final mode = state.uri.queryParameters['mode'] ?? 'login';
          final email = state.uri.queryParameters['email'] ?? '';
          return ClerkAuthScreen(
            mode: mode,
            email: email,
          );
        },
      ),
      GoRoute(
        path: '/pin',
        name: 'pin-detail',
        builder: (context, state) {
          final pin = state.extra! as PinEntity;
          return PinDetailScreen(pin: pin);
        },
      ),
    ],
  );
});
