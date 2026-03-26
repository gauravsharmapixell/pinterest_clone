import 'package:flutter/material.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  void _shareAction(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label action tapped'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 10, 22, 24),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close, size: 34),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 220,
                height: 220,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFEAF3FB),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.campaign_outlined,
                  size: 100,
                  color: Color(0xFF357CC8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Find inspiration\ntogether',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 26),
            const _InviteStep(
              index: '1.',
              title: 'Share your link',
              body:
                  'Your friends need to follow you using your link to message you',
            ),
            const SizedBox(height: 20),
            const _InviteStep(
              index: '2.',
              title: 'Your friends follow you',
              body:
                  'Each link works for a few friends at a time, but you can get as many as you need',
            ),
            const SizedBox(height: 20),
            const _InviteStep(
              index: '3.',
              title: 'Follow back!',
              body:
                  'Once you\'re following each other, you can share ideas, goals and more via direct messages',
            ),
            const SizedBox(height: 36),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: [
                _ShareOption(
                  label: 'WhatsApp',
                  icon: Icons.chat,
                  onTap: () => _shareAction(context, 'WhatsApp'),
                ),
                _ShareOption(
                  label: 'Copy link',
                  icon: Icons.link,
                  onTap: () => _shareAction(context, 'Copy link'),
                ),
                _ShareOption(
                  label: 'Telegram',
                  icon: Icons.send,
                  onTap: () => _shareAction(context, 'Telegram'),
                ),
                _ShareOption(
                  label: 'Google\nMessages',
                  icon: Icons.message,
                  onTap: () => _shareAction(context, 'Google Messages'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InviteStep extends StatelessWidget {
  const _InviteStep({
    required this.index,
    required this.title,
    required this.body,
  });

  final String index;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          index,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShareOption extends StatelessWidget {
  const _ShareOption({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 92,
        child: Column(
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0E8),
                borderRadius: BorderRadius.circular(22),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 38),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
