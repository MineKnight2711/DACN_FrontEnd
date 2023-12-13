import 'package:flutter/material.dart';

class ShowRatingBar extends StatelessWidget {
  final double rating;
  final double size;

  const ShowRatingBar({super.key, required this.rating, this.size = 50});

  @override
  Widget build(BuildContext context) {
    List<Widget> starlist = [];
    int realNumber = rating.floor(); //2.55->2
    int partNumber = ((rating - realNumber) * 10).ceil(); //Số phẩy

    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        starlist.add(Icon(
          Icons.star,
          color: Colors.amber,
          size: size,
        ));
      } else if (i == realNumber) {
        starlist.add(SizedBox(
          height: size,
          width: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: size,
              ),
              ClipRect(
                clipper: Clipper(part: partNumber),
                child: Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: size,
                ),
              ),
            ],
          ),
        ));
      } else {
        starlist.add(Icon(
          Icons.star,
          color: Colors.grey,
          size: size,
        ));
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: starlist,
    );
  }
}

class Clipper extends CustomClipper<Rect> {
  final int part;
  Clipper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
        (size.width / 10) * part, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return oldClipper != this;
  }
}
