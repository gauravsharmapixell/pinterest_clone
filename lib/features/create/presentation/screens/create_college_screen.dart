import 'package:flutter/material.dart';

class CreateCollageScreen extends StatefulWidget {
  const CreateCollageScreen({super.key});

  @override
  State<CreateCollageScreen> createState() => _CreateCollageScreenState();
}

class _CreateCollageScreenState extends State<CreateCollageScreen> {
  int? _selectedIndex;
  final TextEditingController _controller = TextEditingController();

  static const List<String> cutouts = [
    'https://images.pexels.com/photos/373548/pexels-photo-373548.jpeg',
    'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg',
    'https://images.pexels.com/photos/1001990/pexels-photo-1001990.jpeg',
    'https://images.pexels.com/photos/325185/pexels-photo-325185.jpeg',
    'https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg',
    'https://images.pexels.com/photos/2047905/pexels-photo-2047905.jpeg',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_selectedIndex == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Collage draft created'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canProceed = _selectedIndex != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EF),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, size: 34),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.undo, size: 30, color: Colors.grey),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz, size: 34),
                  ),
                  GestureDetector(
                    onTap: canProceed ? _nextStep : null,
                    child: Container(
                      width: 88,
                      height: 46,
                      decoration: BoxDecoration(
                        color: canProceed
                            ? const Color(0xFFE60023)
                            : const Color(0xFFE5E4DD),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18,
                          color: canProceed
                              ? Colors.white
                              : const Color(0xFF9A9A9A),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(14, 8, 14, 0),
                    height: 290,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E8E5),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: _selectedIndex == null
                        ? const Center(
                            child: Text(
                              'Select a cutout to begin',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF7A7A72),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(26),
                            child: Image.network(
                              cutouts[_selectedIndex!],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(28)),
                    ),
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 52,
                          height: 6,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE1DFD8),
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Create with collages',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Mix and match ideas, piece together your vision and create something uniquely yours',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFFB7B7B7),
                              width: 1.4,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              const Icon(Icons.search, size: 28),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  decoration: const InputDecoration(
                                    hintText: 'Search',
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Cutouts for you',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 126,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: cutouts.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final isSelected = _selectedIndex == index;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFFE60023)
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      cutouts[index],
                                      width: 126,
                                      height: 126,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
