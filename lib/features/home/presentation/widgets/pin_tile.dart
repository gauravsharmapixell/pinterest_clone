import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/pin_entity.dart';

class PinTile extends StatelessWidget {
  const PinTile({
    super.key,
    required this.pin,
  });

  final PinEntity pin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed('pin-detail', extra: pin),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: pin.imageUrl,
              height: pin.imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: pin.imageHeight,
                color: const Color(0xFFF1F1F1),
              ),
              errorWidget: (context, url, error) => Container(
                height: pin.imageHeight,
                color: const Color(0xFFF1F1F1),
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image_outlined),
              ),
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
  }
}
