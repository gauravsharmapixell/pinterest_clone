import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  static const List<Map<String, dynamic>> savedPins = [
    {
      'imageUrl': 'https://images.pexels.com/photos/325185/pexels-photo-325185.jpeg',
      'height': 240.0,
    },
    {
      'imageUrl': 'https://images.pexels.com/photos/67112/pexels-photo-67112.jpeg',
      'height': 320.0,
    },
    {
      'imageUrl': 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg',
      'height': 220.0,
    },
    {
      'imageUrl': 'https://images.pexels.com/photos/1323550/pexels-photo-1323550.jpeg',
      'height': 300.0,
    },
    {
      'imageUrl': 'https://images.pexels.com/photos/934070/pexels-photo-934070.jpeg',
      'height': 350.0,
    },
    {
      'imageUrl': 'https://images.pexels.com/photos/2047905/pexels-photo-2047905.jpeg',
      'height': 260.0,
    },
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ClerkAuthBuilder(
      builder: (context, authState) {
        final user = authState.user;
        final fullName = [
          user?.firstName ?? '',
          user?.lastName ?? '',
        ].where((part) => part.trim().isNotEmpty).join(' ').trim();

        final displayName = fullName.isNotEmpty ? fullName : 'Pinterest User';
        final username = user?.username?.isNotEmpty == true
            ? '@${user!.username}'
            : '@pinterestuser';
        final initial = displayName.characters.first.toUpperCase();

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: CustomScrollView(
              key: const PageStorageKey('profile_screen_scroll'),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Spacer(),
                            IconButton(
                              onPressed: () async {
                                await authState.signOut();
                              },
                              icon: const Icon(Icons.logout_rounded),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 92,
                          height: 92,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE9E9E9),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            initial,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111111),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          displayName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111111),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          username,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF777777),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          '12.4k followers  •  186 following',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF444444),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _ProfileActionButton(
                              label: 'Share',
                              onTap: () {},
                            ),
                            const SizedBox(width: 10),
                            _ProfileActionButton(
                              label: 'Edit profile',
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _ProfileTabChip(
                              label: 'Created',
                              isSelected: false,
                            ),
                            SizedBox(width: 10),
                            _ProfileTabChip(
                              label: 'Saved',
                              isSelected: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  sliver: SliverMasonryGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childCount: savedPins.length,
                    itemBuilder: (context, index) {
                      final pin = savedPins[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          pin['imageUrl'] as String,
                          height: pin['height'] as double,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfileActionButton extends StatelessWidget {
  const _ProfileActionButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xFFF2F2F2),
          foregroundColor: const Color(0xFF111111),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ProfileTabChip extends StatelessWidget {
  const _ProfileTabChip({
    required this.label,
    required this.isSelected,
  });

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(22),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
