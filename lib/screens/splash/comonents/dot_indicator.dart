import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    required this.currentPage,
    required this.index,
  }) : super(key: key);

  final int currentPage;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: currentPage == index ? 12 : 6,
      width: 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class HorizontalDotIndicator extends StatelessWidget {
  const HorizontalDotIndicator({
    Key? key,
    required this.currentPage,
    required this.index,
  }) : super(key: key);

  final int currentPage;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 5),
      width: currentPage == index ? 15 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
