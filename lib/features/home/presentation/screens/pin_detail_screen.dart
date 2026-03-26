import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';

import '../../domain/entities/pin_entity.dart';

class PinDetailScreen extends StatefulWidget {
  const PinDetailScreen({
    super.key,
    required this.pin,
  });

  final PinEntity pin;

  @override
  State<PinDetailScreen> createState() => _PinDetailScreenState();
}

class _PinDetailScreenState extends State<PinDetailScreen> {
  late final TransformationController _inlineController;
  TapDownDetails? _inlineDoubleTapDetails;
  bool _isInlineZoomed = false;
  int _inlinePointerCount = 0;

  static const List<Map<String, dynamic>> moreIdeas = [
    {
      'id': 'm1',
      'title': 'Cozy room idea',
      'imageUrl':
          'https://images.pexels.com/photos/325185/pexels-photo-325185.jpeg',
      'height': 240.0,
    },
    {
      'id': 'm2',
      'title': 'Street style board',
      'imageUrl':
          'https://images.pexels.com/photos/67112/pexels-photo-67112.jpeg',
      'height': 300.0,
    },
    {
      'id': 'm3',
      'title': 'Workspace setup',
      'imageUrl':
          'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg',
      'height': 220.0,
    },
    {
      'id': 'm4',
      'title': 'Food inspiration',
      'imageUrl':
          'https://images.pexels.com/photos/1323550/pexels-photo-1323550.jpeg',
      'height': 280.0,
    },
    {
      'id': 'm5',
      'title': 'Soft decor board',
      'imageUrl':
          'https://images.pexels.com/photos/373548/pexels-photo-373548.jpeg',
      'height': 250.0,
    },
    {
      'id': 'm6',
      'title': 'Minimal style',
      'imageUrl':
          'https://images.pexels.com/photos/2047905/pexels-photo-2047905.jpeg',
      'height': 320.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    _inlineController = TransformationController();
    _inlineController.addListener(_handleInlineTransformChanged);
  }

  @override
  void dispose() {
    _inlineController.removeListener(_handleInlineTransformChanged);
    _inlineController.dispose();
    super.dispose();
  }

  void _handleInlineTransformChanged() {
    final isZoomed = _inlineController.value.getMaxScaleOnAxis() > 1.001;
    if (isZoomed != _isInlineZoomed) {
      setState(() {
        _isInlineZoomed = isZoomed;
      });
    }
  }

  void _resetInlineZoom() {
    _inlineController.value = Matrix4.identity();
  }

  void _openZoom(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _ZoomableImageScreen(imageUrl: widget.pin.imageUrl),
      ),
    );
  }

  void _handleInlineDoubleTap() {
    if (_inlineDoubleTapDetails == null) return;

    final currentScale = _inlineController.value.getMaxScaleOnAxis();
    if (currentScale > 1.0) {
      _resetInlineZoom();
      return;
    }

    final position = _inlineDoubleTapDetails!.localPosition;
    const zoom = 2.0;

    _inlineController.value = Matrix4.identity()
      ..translate(-position.dx * (zoom - 1), -position.dy * (zoom - 1))
      ..scale(zoom);
  }

  @override
  Widget build(BuildContext context) {
    final heroHeight = widget.pin.imageHeight + 140;
    final lockScroll = _isInlineZoomed || _inlinePointerCount > 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            physics: lockScroll
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                pinned: true,
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.ios_share_outlined),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 90),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Listener(
                        onPointerDown: (_) {
                          setState(() {
                            _inlinePointerCount++;
                          });
                        },
                        onPointerUp: (_) {
                          setState(() {
                            if (_inlinePointerCount > 0) {
                              _inlinePointerCount--;
                            }
                          });
                        },
                        onPointerCancel: (_) {
                          setState(() {
                            if (_inlinePointerCount > 0) {
                              _inlinePointerCount--;
                            }
                          });
                        },
                        child: GestureDetector(
                          onTap: () => _openZoom(context),
                          onDoubleTapDown: (details) {
                            _inlineDoubleTapDetails = details;
                          },
                          onDoubleTap: _handleInlineDoubleTap,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              width: double.infinity,
                              height: heroHeight,
                              child: InteractiveViewer(
                                transformationController: _inlineController,
                                minScale: 1,
                                maxScale: 4.5,
                                panEnabled: _isInlineZoomed,
                                scaleEnabled: true,
                                boundaryMargin: EdgeInsets.zero,
                                clipBehavior: Clip.hardEdge,
                                child: CachedNetworkImage(
                                  imageUrl: widget.pin.imageUrl,
                                  width: double.infinity,
                                  height: heroHeight,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    height: heroHeight,
                                    color: const Color(0xFFF1F1F1),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    height: heroHeight,
                                    color: const Color(0xFFF1F1F1),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.broken_image_outlined,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 22,
                            backgroundColor: Color(0xFFEAEAEA),
                            child: Text(
                              'A',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Alex Morgan',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF111111),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '1.2M monthly views',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF6A6A6A),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xFFF2F2F2),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                ),
                              ),
                              child: const Text(
                                'Follow',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'More like this',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111111),
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childCount: moreIdeas.length,
                  itemBuilder: (context, index) {
                    final item = moreIdeas[index];
                    final nextPin = PinEntity(
                      id: item['id'] as String,
                      title: item['title'] as String,
                      imageUrl: item['imageUrl'] as String,
                      imageHeight: item['height'] as double,
                    );

                    return GestureDetector(
                      onTap: () =>
                          context.pushNamed('pin-detail', extra: nextPin),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Image.network(
                              item['imageUrl'] as String,
                              height: item['height'] as double,
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
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
            ],
          ),
          Positioned(
            left: 14,
            right: 14,
            bottom: 14,
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3F3F3),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.favorite_border),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3F3F3),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.file_upload_outlined),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE60023),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ZoomableImageScreen extends StatelessWidget {
  const _ZoomableImageScreen({
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(imageUrl),
              minScale: PhotoViewComputedScale.contained,
              initialScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 4,
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              tightMode: true,
              loadingBuilder: (context, event) {
                return const Center(
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(230),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
