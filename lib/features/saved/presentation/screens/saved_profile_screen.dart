import 'package:flutter/material.dart';

import '../../../create/presentation/screens/create_college_screen.dart';
import '../../../create/presentation/screens/gallery_permission_screen.dart';

class SavedProfileScreen extends StatefulWidget {
  const SavedProfileScreen({super.key});

  @override
  State<SavedProfileScreen> createState() => _SavedProfileScreenState();
}

class _SavedProfileScreenState extends State<SavedProfileScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

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

  void _openCreatePin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const GalleryPermissionScreen(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 72,
          color: Colors.white,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share_outlined),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 38,
                            backgroundColor: Color(0xFFFF8E98),
                            child: Text(
                              'G',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 34,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.edit, size: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Gaurav',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(Icons.lock_outline, size: 24),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              'gauravoffcampus',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    '0 followers · 0 following',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Add a short bio to personalise your profile',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ),
                      Icon(Icons.edit_outlined, size: 22),
                    ],
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF0F0E8),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: const Text(
                        'Edit profile',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black,
              labelStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Created'),
                Tab(text: 'Saved'),
                Tab(text: 'Collages'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _ProfileEmpty(
                    title: 'Inspire with a Pin',
                    buttonLabel: 'Create',
                    onPressed: _openCreatePin,
                  ),
                  const _ProfileEmpty(
                    title: 'Save what inspires you',
                    buttonLabel: 'Explore',
                  ),
                  _ProfileEmpty(
                    title: 'Create with collages',
                    buttonLabel: 'Create',
                    onPressed: _openCreateCollage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileEmpty extends StatelessWidget {
  const _ProfileEmpty({
    required this.title,
    required this.buttonLabel,
    this.onPressed,
  });

  final String title;
  final String buttonLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: onPressed ?? () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE60023),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 28),
              ),
              child: Text(
                buttonLabel,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavLabel extends StatelessWidget {
  const _NavLabel({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black, size: 30),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
