import 'package:flutter/material.dart';

class GalleryPermissionScreen extends StatelessWidget {
  const GalleryPermissionScreen({super.key});

  void _allowAccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gallery permission flow placeholder'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF35352F),
      body: Column(
        children: [
          const Spacer(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              children: [
                Text(
                  'Allow access to continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  'To create Pins, Pinterest needs permission to access your gallery to upload media and photos from this device.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 28),
                Text(
                  '1  Gallery access',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF8E8E88),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () => _allowAccess(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 28),
              ),
              child: const Text(
                'Allow access',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const Spacer(),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _BottomTool(icon: Icons.camera_alt_outlined),
                  _BottomTool(icon: Icons.public),
                  _BottomTool(icon: Icons.filter_none),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomTool extends StatelessWidget {
  const _BottomTool({
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0E8),
        borderRadius: BorderRadius.circular(22),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 34),
    );
  }
}
