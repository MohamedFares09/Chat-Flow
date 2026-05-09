import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAssetImage extends StatelessWidget {
  const CustomAssetImage(
    this.asset, {
    this.width,
    this.height,
    this.fit,
    super.key,
  });

  final String asset;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if (asset.endsWith('.svg')) {
      return SvgPicture.asset(
        asset,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
    }

    return Image.asset(
      asset,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
