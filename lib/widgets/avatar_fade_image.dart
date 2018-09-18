import 'package:flutter/material.dart';

class AvatarFadeImage extends StatelessWidget {
  final String imageUrl;

  AvatarFadeImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: FadeInImage.assetNetwork(
        placeholder: 'res/avatar_placeholder.png',
        fit: BoxFit.contain,
        image: imageUrl,
      ),
    );
  }
}
