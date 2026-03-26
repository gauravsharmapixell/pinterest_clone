import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shell/presentation/screens/main_shell_screen.dart';

class ClerkAuthScreen extends StatelessWidget {
  const ClerkAuthScreen({
    super.key,
    required this.mode,
    required this.email,
  });

  final String mode;
  final String email;

  void _handleBack(BuildContext context) {
    if (GoRouter.of(context).canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClerkErrorListener(
      child: ClerkAuthBuilder(
        signedInBuilder: (context, authState) {
          return const MainShellScreen();
        },
        signedOutBuilder: (context, authState) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => _handleBack(context),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        const Expanded(
                          child: Text(
                            'Pinterest',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFE60023),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Log in or sign up to continue.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF5F5F5F),
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: ClerkAuthentication(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
