import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shell/presentation/screens/main_shell_screen.dart';

class AuthGateScreen extends StatelessWidget {
  const AuthGateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ClerkErrorListener(
      child: ClerkAuthBuilder(
        signedInBuilder: (context, authState) => const MainShellScreen(),
        signedOutBuilder: (context, authState) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
                children: [
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 360,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: const [
                        Positioned(
                          left: -28,
                          top: 18,
                          child: _AuthImageCard(
                            width: 132,
                            height: 162,
                            imageUrl:
                                'https://images.pexels.com/photos/271743/pexels-photo-271743.jpeg',
                          ),
                        ),
                        Positioned(
                          right: -22,
                          top: -8,
                          child: _AuthImageCard(
                            width: 140,
                            height: 110,
                            imageUrl:
                                'https://images.pexels.com/photos/373548/pexels-photo-373548.jpeg',
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 78,
                          child: Center(
                            child: _AuthImageCard(
                              width: 300,
                              height: 300,
                              radius: 30,
                              imageUrl:
                                  'https://images.pexels.com/photos/994523/pexels-photo-994523.jpeg',
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 132,
                          child: _AuthImageCard(
                            width: 124,
                            height: 156,
                            imageUrl:
                                'https://images.pexels.com/photos/3373739/pexels-photo-3373739.jpeg',
                          ),
                        ),
                        Positioned(
                          left: -26,
                          bottom: 4,
                          child: _AuthImageCard(
                            width: 144,
                            height: 184,
                            imageUrl:
                                'https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg',
                          ),
                        ),
                        Positioned(
                          right: -18,
                          bottom: 36,
                          child: _AuthImageCard(
                            width: 118,
                            height: 110,
                            imageUrl:
                                'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE60023),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'P',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Create a life\nyou love',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                      height: 1.08,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => context.push('/auth'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE60023),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        'Continue to Pinterest',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'By continuing, you agree to Pinterest\'s Terms of Service\nand acknowledge that you\'ve read our Privacy Policy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF444444),
                      height: 1.45,
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

class _AuthImageCard extends StatelessWidget {
  const _AuthImageCard({
    required this.width,
    required this.height,
    required this.imageUrl,
    this.radius = 26,
  });

  final double width;
  final double height;
  final double radius;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
