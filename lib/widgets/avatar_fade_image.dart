import 'package:flutter/material.dart';

class AvatarFadeImage extends StatelessWidget {
  final String imageUrl;
  final double scale;

  AvatarFadeImage(this.imageUrl, this.scale);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: FadeInImage.assetNetwork(
        placeholder: 'res/avatar_placeholder.png',
        imageScale: scale,
        fit: BoxFit.contain,
        image: imageUrl,
      ),
    );
  }
}
