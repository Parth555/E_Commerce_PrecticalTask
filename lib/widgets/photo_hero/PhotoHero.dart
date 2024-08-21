import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero({Key? key, required this.photo, required this.onTap, this.tag, this.width, this.height}) : super(key: key);

  final String photo;
  final String? tag;
  final VoidCallback onTap;
  final double? width;
  final double? height;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width,
      child: Hero(
        tag: tag ?? photo,
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              photo,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
