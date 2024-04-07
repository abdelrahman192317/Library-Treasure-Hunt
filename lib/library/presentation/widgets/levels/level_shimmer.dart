import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantsShimmer extends StatelessWidget {
  const RestaurantsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[300]!,
      child: Card(
          margin: EdgeInsets.all(size.height * 0.01),
          child: Container(
            padding: EdgeInsets.all(size.height * 0.01),
            height: size.height * 0.1,
            width: size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
          )),
    );
  }
}
