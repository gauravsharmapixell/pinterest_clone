import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PinTileShimmer extends StatelessWidget {
  const PinTileShimmer({
    super.key,
    required this.imageHeight,
  });

  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFF1F1F1),
      highlightColor: const Color(0xFFF8F8F8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: imageHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 12,
            width: double.infinity,
            decoration: BorderRadius.circular(8).toBoxDecoration(),
          ),
          const SizedBox(height: 6),
          Container(
            height: 12,
            width: 90,
            decoration: BorderRadius.circular(8).toBoxDecoration(),
          ),
        ],
      ),
    );
  }
}

extension on BorderRadius {
  BoxDecoration toBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: this,
    );
  }
}
