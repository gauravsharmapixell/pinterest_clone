import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../create/presentation/screens/create_board_screen.dart';
import '../../../create/presentation/screens/create_college_screen.dart';
import '../../../create/presentation/screens/gallery_permission_screen.dart';
import '../../../inbox/presentation/screens/inbox_screen.dart';
import '../controllers/home_controller.dart';
import '../widgets/pin_tile.dart';
import '../widgets/pin_tile_shimmer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  static const List<double> shimmerHeights = [
    330,
    330,
    360,
    290,
    340,
    310,
    320,
    300,
  ];

  @override
  bool get wantKeepAlive => true;

  Future<void> _refreshPins() async {
    ref.read(homeRefreshTriggerProvider.notifier).state++;
    await ref.read(homePinsProvider.future);
  }

  void _openCreateFlow(Widget screen) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  void _openCreateSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, size: 34),
                    ),
                    const Spacer(),
                    const Text(
                      'Start creating now',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _CreateOption(
                      icon: Icons.push_pin_outlined,
                      label: 'Pin',
                      onTap: () =>
                          _openCreateFlow(const GalleryPermissionScreen()),
                    ),
                    _CreateOption(
                      icon: Icons.content_cut_outlined,
                      label: 'Collage',
                      onTap: () =>
                          _openCreateFlow(const CreateCollageScreen()),
                    ),
                    _CreateOption(
                      icon: Icons.dashboard_outlined,
                      label: 'Board',
                      onTap: () => _openCreateFlow(const CreateBoardScreen()),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openInboxScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const InboxScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final pinsAsync = ref.watch(homePinsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 14, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
  mainAxisAlignment: MainAxisAlignment.start,
  // crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    // The "P" logo - use a circular container or an Image for accuracy
    Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 11, 11, 11), // Pinterest Red
        shape: BoxShape.circle,
      ),
      child: const Text(
        'Ƥ',
        style: TextStyle(
          fontSize: 30, // Adjusted to match the scaled text
          height: 1.2,
          color: Colors.white,
          fontWeight: FontWeight.w900, // Extra bold for the logo
          fontFamily: 'Helvetica Neue', // Use Helvetica or custom Neue Haas Grotesk
        ),
      ),
    ),
    const SizedBox(width: 2),
    Text(
      'Pinterest',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w900, // Bold weight
        letterSpacing: -1, // Tighter spacing for the brand look
        fontFamily: 'Helvetica Neue',
         foreground: Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 100 // Adjust this to make it even thicker
      ..color = Colors.black,
      ),
    ),
  ],
)

                  ),
                  IconButton(
                    onPressed: _openCreateSheet,
                    icon: const Icon(Icons.add, size: 36),
                  ),
                  IconButton(
                    onPressed: _openInboxScreen,
                    icon: const Icon(Icons.chat_bubble_outline, size: 32),
                  ),
                ],
              ),
            ),
            Expanded(
              child: pinsAsync.when(
                data: (pins) {
                  return RefreshIndicator(
                    color: Colors.black,
                    onRefresh: _refreshPins,
                    child: MasonryGridView.count(
                      key: const PageStorageKey('home_feed_grid'),
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 18),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemCount: pins.length,
                      itemBuilder: (context, index) {
                        return PinTile(pin: pins[index]);
                      },
                    ),
                  );
                },
                loading: () {
                  return MasonryGridView.count(
                    key: const PageStorageKey('home_feed_loading_grid'),
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 18),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    itemCount: shimmerHeights.length,
                    itemBuilder: (context, index) {
                      return PinTileShimmer(imageHeight: shimmerHeights[index]);
                    },
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error_outline, size: 36),
                          const SizedBox(height: 12),
                          Text(
                            error.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              ref.read(homeRefreshTriggerProvider.notifier).state++;
                            },
                            child: const Text('Try again'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateOption extends StatelessWidget {
  const _CreateOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0E8),
              borderRadius: BorderRadius.circular(22),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 40),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
