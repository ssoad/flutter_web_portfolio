import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/image_helper.dart';

class CustomImage extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const CustomImage({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isNetwork = ImageHelper.isNetworkImage(imagePath);
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: Container(
        height: height,
        width: width,
        child: isNetwork ? _buildNetworkImage() : _buildAssetImage(),
      ),
    );
  }

  Widget _buildNetworkImage() {
    return Image.network(
      imagePath,
      fit: fit,
      loadingBuilder: _loadingBuilder,
      errorBuilder: _errorBuilder,
    );
  }

  Widget _buildAssetImage() {
    return Image.asset(
      imagePath,
      fit: fit,
      errorBuilder: _errorBuilder,
    );
  }

  Widget _loadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) {
      return AnimatedOpacity(
        opacity: 1,
        duration: const Duration(milliseconds: 500),
        child: child,
      );
    }
    return _buildShimmer();
  }

  Widget _errorBuilder(
      BuildContext context, Object error, StackTrace? stackTrace) {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.error_outline, size: 40),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }
}
