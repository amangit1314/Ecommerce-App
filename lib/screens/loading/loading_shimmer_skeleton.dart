import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/loading/shimmer_box.dart';
import 'package:soni_store_app/screens/loading/skelton.dart';

class LoadingShimmerSkelton extends StatelessWidget {
  const LoadingShimmerSkelton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        const Skelton(),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Flexible(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Skelton(height: 10),
                  ],
                ),
                const ShimmerBox(child: Skelton(height: 14)),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 8.0, top: 4, bottom: 8),
          child: ShimmerBox(child: Skelton(height: 12)),
        ),
      ],
    );
  }
}
