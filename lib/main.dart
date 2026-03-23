import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/constants/auth_constants.dart';

void main() {
  runApp(
    ProviderScope(
      child: ClerkAuth(
        config: ClerkAuthConfig(
          publishableKey: AuthConstants.clerkPublishableKey,
        ),
        child: const PinterestCloneApp(),
      ),
    ),
  );
}
