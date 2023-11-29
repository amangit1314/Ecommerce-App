import 'package:flutter/material.dart';

import 'shimmer_box.dart';
import 'skelton.dart';

class LoadingShimmerSkelton extends StatelessWidget {
  const LoadingShimmerSkelton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        Skelton(),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: Flexible(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Skelton(height: 10),
                  ],
                ),
                ShimmerBox(child: Skelton(height: 14)),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8.0, top: 4, bottom: 8),
          child: ShimmerBox(child: Skelton(height: 12)),
        ),
      ],
    );
  }
}
