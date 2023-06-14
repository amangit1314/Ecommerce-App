import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Shimmer.fromColors(
          period: const Duration(milliseconds: 1500),
          direction: ShimmerDirection.ltr,
          loop: 2,
          enabled: true,
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey,
          child: AnimatedContainer(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15)),
            duration: const Duration(milliseconds: 500),
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: child,
          ),
        );
      },
    );
  }
}
