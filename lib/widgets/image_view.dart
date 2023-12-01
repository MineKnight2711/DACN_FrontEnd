import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String imageUrl;

  const ImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: InteractiveViewer(
          maxScale: 5.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
