import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SizedImage extends StatelessWidget {
  const SizedImage({
    Key? key,
    required this.imageUrl,
    required this.size,
  }) : super(key: key);

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: imageUrl.split(".").last == "svg"
          ? SvgPicture.network(
              imageUrl,
              fit: BoxFit.contain,
            )
          : Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
    );
  }
}
