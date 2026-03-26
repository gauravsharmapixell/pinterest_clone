import 'package:flutter/material.dart';

import 'invite_friends_screen.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  void _openInvite(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const InviteFriendsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Inbox',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_outlined, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 26),
                ],
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => _openInvite(context),
                borderRadius: BorderRadius.circular(18),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 62,
                        height: 62,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1E8),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.person_add_alt_1_outlined,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Invite your friends',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Connect to start chatting',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF6F6F6F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Updates',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 240,
                      height: 240,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFEAF3FB),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.campaign_outlined,
                        size: 108,
                        color: Color(0xFF357CC8),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'Updates show activity on your Pins and boards and give you tips on topics to explore. They\'ll be here soon.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF6F6F6F),
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
