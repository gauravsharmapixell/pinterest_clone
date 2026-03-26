import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../home/domain/entities/pin_entity.dart';
import '../../../home/presentation/controllers/home_controller.dart';

class SearchSuggestionsScreen extends ConsumerStatefulWidget {
  const SearchSuggestionsScreen({super.key});

  @override
  ConsumerState<SearchSuggestionsScreen> createState() =>
      _SearchSuggestionsScreenState();
}

class _SearchSuggestionsScreenState
    extends ConsumerState<SearchSuggestionsScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<String> _recentSearches = [
    'laptop wallpaper',
    'tattoo ideas',
  ];

  static const List<PinEntity> fallbackPins = [
    PinEntity(
      id: 'search-1',
      title: 'painting ideas on canvas',
      imageUrl:
          'https://images.pexels.com/photos/1266808/pexels-photo-1266808.jpeg',
      imageHeight: 200,
    ),
    PinEntity(
      id: 'search-2',
      title: 'art sketches',
      imageUrl:
          'https://images.pexels.com/photos/102127/pexels-photo-102127.jpeg',
      imageHeight: 200,
    ),
    PinEntity(
      id: 'search-3',
      title: 'art ideas',
      imageUrl:
          'https://images.pexels.com/photos/3641377/pexels-photo-3641377.jpeg',
      imageHeight: 200,
    ),
    PinEntity(
      id: 'search-4',
      title: 'oil painting',
      imageUrl: 'https://images.pexels.com/photos/20967/pexels-photo.jpg',
      imageHeight: 200,
    ),
    PinEntity(
      id: 'search-5',
      title: 'butterfly drawing',
      imageUrl:
          'https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg',
      imageHeight: 200,
    ),
    PinEntity(
      id: 'search-6',
      title: 'sketchbook art inspiration',
      imageUrl:
          'https://images.pexels.com/photos/1323712/pexels-photo-1323712.jpeg',
      imageHeight: 200,
    ),
  ];

  String get _query => _controller.text.trim().toLowerCase();

  void _openPin(PinEntity pin) {
    context.pushNamed('pin-detail', extra: pin);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<PinEntity> _filterPins(List<PinEntity> pins) {
    if (_query.isEmpty) {
      return pins;
    }

    return pins.where((pin) {
      return pin.title.toLowerCase().contains(_query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final pinsAsync = ref.watch(homePinsProvider);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return pinsAsync.when(
      data: (pins) {
        final sourcePins = pins.isEmpty ? fallbackPins : pins;
        final filtered = _filterPins(sourcePins);

        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 18),
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 52,
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
                                autofocus: true,
                                onChanged: (_) => setState(() {}),
                                decoration: const InputDecoration(
                                  hintText: 'Search for ideas',
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                            if (_controller.text.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  _controller.clear();
                                  setState(() {});
                                },
                                child: const Icon(Icons.close),
                              )
                            else
                              const Icon(Icons.camera_alt_outlined),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                if (_query.isEmpty) ...[
                  ..._recentSearches.asMap().entries.map(
                    (entry) {
                      final pin = sourcePins[entry.key % sourcePins.length];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () => _openPin(pin),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.network(
                                  pin.imageUrl,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Text(
                                  entry.value,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Icon(Icons.close, color: Colors.black54),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Discover visual art',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),
                ] else ...[
                  Text(
                    filtered.isEmpty
                        ? 'No results for "${_controller.text.trim()}"'
                        : 'Results for "${_controller.text.trim()}"',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
                if (filtered.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Center(
                      child: Text(
                        'No ideas found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      mainAxisExtent: 188,
                    ),
                    itemBuilder: (context, index) {
                      final pin = filtered[index];
                      return GestureDetector(
                        onTap: () => _openPin(pin),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.network(
                                pin.imageUrl,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 48,
                              child: Text(
                                pin.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 1.15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(child: CircularProgressIndicator(color: Colors.black)),
        ),
      ),
      error: (_, __) => const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Text(
              'Unable to load search ideas',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
