import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final double rating;
  final int starCount;
  final double size;
  final double spacing;
  final RatingChangeCallback callback;

  const StarRating({
    required this.rating,
    this.starCount = 5,
    this.spacing = 0.0,
    this.size = 25,
    required this.callback,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon = Icon(Icons.star_rate ,color: index >= rating ? Colors.grey: Colors.blue, size: size,);



    return GestureDetector(
      onTap: () {
        callback(index + 1.0);
      },
      onHorizontalDragUpdate: (dragDetails) {
        RenderBox box = context.findRenderObject()! as RenderBox;
        var _pos = box.globalToLocal(dragDetails.globalPosition);
        var i = _pos.dx / size;
        var newRating = i.round().toDouble();

        if (newRating > starCount) {
          newRating = starCount.toDouble();
        }
        if (newRating < 0) {
          newRating = 0.0;
        }

        callback(newRating);
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Wrap(
          alignment: WrapAlignment.start,
          spacing: spacing,
          children:
              List.generate(starCount, (index) => buildStar(context, index))),
    );
  }
}
