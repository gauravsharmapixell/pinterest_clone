import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../home/domain/entities/pin_entity.dart';
import '../../../home/presentation/controllers/home_controller.dart';
import 'search_suggestion_screen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen>
    with AutomaticKeepAliveClientMixin {
  int _heroIndex = 0;

  static const List<PinEntity> fallbackPins = [
    PinEntity(
      id: 'fallback-1',
      title: 'Creative recipes with coffee',
      imageUrl:
          'https://images.pexels.com/photos/3026808/pexels-photo-3026808.jpeg',
      imageHeight: 420,
    ),
    PinEntity(
      id: 'fallback-2',
      title: 'Celebrate in style',
      imageUrl:
          'https://images.pexels.com/photos/291759/pexels-photo-291759.jpeg',
      imageHeight: 420,
    ),
    PinEntity(
      id: 'fallback-3',
      title: 'Dreamy bedroom ideas',
      imageUrl:
          'https://images.pexels.com/photos/271743/pexels-photo-271743.jpeg',
      imageHeight: 420,
    ),
    PinEntity(
      id: 'fallback-4',
      title: 'Romantic room details',
      imageUrl:
          'https://images.pexels.com/photos/373548/pexels-photo-373548.jpeg',
      imageHeight: 220,
    ),
    PinEntity(
      id: 'fallback-5',
      title: 'Creative coffee board',
      imageUrl:
          'https://images.pexels.com/photos/3026808/pexels-photo-3026808.jpeg',
      imageHeight: 220,
    ),
  ];

  @override
  bool get wantKeepAlive => true;

  void _openPin(PinEntity pin) {
    context.pushNamed('pin-detail', extra: pin);
  }

  void _openSuggestions() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SearchSuggestionsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final pinsAsync = ref.watch(homePinsProvider);


    return pinsAsync.when(
      data: (pins) {
        final sourcePins = pins.isEmpty ? fallbackPins : pins;
        final heroPins = sourcePins.take(3).toList();
        final boardPins = sourcePins.length > 3
            ? sourcePins.skip(3).take(8).toList()
            : sourcePins.take(8).toList();

        if (_heroIndex >= heroPins.length && heroPins.isNotEmpty) {
          _heroIndex = 0;
        }

        final heroPin = heroPins.isNotEmpty ? heroPins[_heroIndex] : fallbackPins.first;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              color: Colors.white,
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                key: const PageStorageKey('search_screen_scroll'),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                      child: GestureDetector(
                        onTap: _openSuggestions,
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFFB7B7B7),
                              width: 1.4,
                            ),
                          ),
                             child: const Row(
                            children: [
                              Icon(Icons.search, size: 28),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Search for ideas',
                                  style: TextStyle(
                                    color: Color(0xFF6F6F6F),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Icon(Icons.camera_alt_outlined),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () => _openPin(heroPin),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                            heroPin.imageUrl,
                            height: 400,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            height: 400,
                            color: Colors.black.withAlpha(90),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 26),
                            child: Text(
                              heroPin.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (heroPins.length > 1)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            heroPins.length,
                            (index) => GestureDetector(
                              onTap: () => setState(() => _heroIndex = index),
                              child: Container(
                                width: 10,
                                height: 10,
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: index == _heroIndex
                                      ? Colors.black
                                      : Colors.black26,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Text(
                        'Explore featured boards',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF444444),
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 2, 16, 10),
                      child: Text(
                        'Ideas you might like',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 300,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: boardPins.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final pin = boardPins[index];
                          return GestureDetector(
                            onTap: () => _openPin(pin),
                            child: SizedBox(
                              width: 176,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      pin.imageUrl,
                                      height: 200,
                                      width: 176,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 42,
                                    child: Text(
                                      pin.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
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
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 18),
                  ),
                ],
              ),
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
      error: (_, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                    child: GestureDetector(
                      onTap: _openSuggestions,
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
                        child: const Row(
                          children: [
                            Icon(Icons.search, size: 28),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Search for ideas',
                                style: TextStyle(
                                  color: Color(0xFF6F6F6F),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Icon(Icons.camera_alt_outlined),
                          ],
                        ),
                      ),
                    ),
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
