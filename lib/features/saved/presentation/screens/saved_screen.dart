import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../../create/presentation/screens/create_board_screen.dart';
import '../../../create/presentation/screens/create_college_screen.dart';
import '../../../home/domain/entities/pin_entity.dart';
import 'saved_profile_screen.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late final TabController _tabController;

  static const List<Map<String, dynamic>> savedPins = [
    {
      'id': 'sp1',
      'title': 'Soft pink collage',
      'imageUrl':
          'https://images.pexels.com/photos/373548/pexels-photo-373548.jpeg',
      'height': 330.0,
    },
    {
      'id': 'sp2',
      'title': 'Broken screen lines',
      'imageUrl':
          'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg',
      'height': 360.0,
    },
    {
      'id': 'sp3',
      'title': 'Floral pattern',
      'imageUrl':
          'https://images.pexels.com/photos/325185/pexels-photo-325185.jpeg',
      'height': 320.0,
    },
    {
      'id': 'sp4',
      'title': 'Cat mood board',
      'imageUrl':
          'https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg',
      'height': 340.0,
    },
    {
      'id': 'sp5',
      'title': 'Dark collage',
      'imageUrl':
          'https://images.pexels.com/photos/67112/pexels-photo-67112.jpeg',
      'height': 300.0,
    },
    {
      'id': 'sp6',
      'title': 'Aesthetic desk',
      'imageUrl':
          'https://images.pexels.com/photos/2047905/pexels-photo-2047905.jpeg',
      'height': 310.0,
    },
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openAccountScreen(ClerkAuthState authState) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _AccountScreen(authState: authState),
      ),
    );
  }

  void _openCreateBoard() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CreateBoardScreen(),
      ),
    );
  }

  void _openCreateCollage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CreateCollageScreen(),
      ),
    );
  }

  void _openPin(Map<String, dynamic> item) {
    final pin = PinEntity(
      id: item['id'] as String,
      title: item['title'] as String,
      imageUrl: item['imageUrl'] as String,
      imageHeight: item['height'] as double,
    );

    context.pushNamed('pin-detail', extra: pin);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ClerkAuthBuilder(
      builder: (context, authState) {
        final user = authState.user;
        final firstName =
            user?.firstName?.trim().isNotEmpty == true ? user!.firstName! : 'G';
        final initial = firstName.characters.first.toUpperCase();

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _openAccountScreen(authState),
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: const Color(0xFFFF8E98),
                          child: Text(
                            initial,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.black,
                          indicatorWeight: 3,
                          indicatorSize: TabBarIndicatorSize.label,
                          dividerColor: Colors.transparent,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black,
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          tabs: const [
                            Tab(text: 'Pins'),
                            Tab(text: 'Boards'),
                            Tab(text: 'Collages'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 18),
                        child: MasonryGridView.count(
                          key: const PageStorageKey('saved_pins_grid'),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          itemCount: savedPins.length,
                          itemBuilder: (context, index) {
                            final item = savedPins[index];
                            return GestureDetector(
                              onTap: () => _openPin(item),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      item['imageUrl'] as String,
                                      height: item['height'] as double,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      right: 8,
                                      bottom: 8,
                                      child: Container(
                                        width: 34,
                                        height: 34,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(235),
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.more_horiz,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      _BoardsEmptyView(onCreateBoard: _openCreateBoard),
                      _CollagesEmptyView(onCreateCollage: _openCreateCollage),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BoardsEmptyView extends StatelessWidget {
  const _BoardsEmptyView({
    required this.onCreateBoard,
  });

  final VoidCallback onCreateBoard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFFB7B7B7),
                      width: 1.4,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Row(
                    children: [
                      Icon(Icons.search, size: 26),
                      SizedBox(width: 12),
                      Text(
                        'Search your Pins',
                        style: TextStyle(
                          color: Color(0xFF6F6F6F),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onCreateBoard,
                child: const Icon(Icons.add, size: 38),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 220,
            height: 220,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFE3D7),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.dashboard_customize_outlined,
              size: 110,
              color: Color(0xFFE26A29),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Organise your ideas',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Pins are sparks of inspiration. Boards are where they live. Create boards to organise your Pins your way.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF444444),
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: onCreateBoard,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE60023),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 28),
              ),
              child: const Text(
                'Create a board',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _CollagesEmptyView extends StatelessWidget {
  const _CollagesEmptyView({
    required this.onCreateCollage,
  });

  final VoidCallback onCreateCollage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      child: Column(
        children: [
          Row(
            children: const [
              _TopChip(label: 'Created by you'),
              SizedBox(width: 10),
              _TopChip(label: 'In progress'),
            ],
          ),
          const Spacer(),
          Container(
            width: 220,
            height: 220,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEAE2FF),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.content_cut_outlined,
              size: 110,
              color: Color(0xFF5A65E8),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Make your first collage',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Snip and paste the best parts of your favourite Pins to create something completely new.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF444444),
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: onCreateCollage,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE60023),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 28),
              ),
              child: const Text(
                'Create collage',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _TopChip extends StatelessWidget {
  const _TopChip({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEDE6),
        borderRadius: BorderRadius.circular(18),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AccountScreen extends StatelessWidget {
  const _AccountScreen({
    required this.authState,
  });

  final ClerkAuthState authState;

  void _openProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SavedProfileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = authState.user;
    final firstName =
        user?.firstName?.trim().isNotEmpty == true ? user!.firstName! : 'G';
    final lastName = user?.lastName?.trim() ?? '';
    final displayName = '$firstName ${lastName.trim()}'.trim();
    final initial = firstName.characters.first.toUpperCase();

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
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const Expanded(
                    child: Text(
                      'Your account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                children: [
                  InkWell(
                    onTap: () => _openProfile(context),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: const Color(0xFFFF8E98),
                            child: Text(
                              initial,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 34,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  displayName.isEmpty
                                      ? 'Pinterest User'
                                      : displayName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'View profile',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF6A6A6A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, size: 30),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const _AccountRow(label: 'Account management'),
                  const _AccountRow(label: 'Profile visibility'),
                  const _AccountRow(label: 'Refine your recommendations'),
                  const _AccountRow(label: 'Claimed external accounts'),
                  const _AccountRow(label: 'Social permissions'),
                  const _AccountRow(label: 'Notifications'),
                  const _AccountRow(label: 'Privacy and data'),
                  const _AccountRow(label: 'Reports and violations centre'),
                  const _SectionLabel(label: 'Login'),
                  const _AccountRow(label: 'Security'),
                  _PlainActionRow(
                    label: 'Log out',
                    onTap: () async {
                      await authState.signOut();
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  const _SectionLabel(label: 'Support'),
                  const _AccountRow(label: 'Teen safety resources'),
                  const _AccountRow(label: 'Help Centre'),
                  const _AccountRow(label: 'Terms of Service'),
                  const _AccountRow(label: 'Privacy Policy'),
                  const _AccountRow(label: 'About'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _AccountRow extends StatelessWidget {
  const _AccountRow({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, size: 30),
          ],
        ),
      ),
    );
  }
}

class _PlainActionRow extends StatelessWidget {
  const _PlainActionRow({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
