import 'package:flutter/material.dart';

import '../../utils/size_config.dart';
import 'components/features/features_section.dart';
import 'components/pants/pants_section.dart';
import 'components/shoes/shoes_section.dart';
import 'components/tshirts/tshirts_section.dart';

class DefaultSearchScreenView extends StatelessWidget {
  const DefaultSearchScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const FeaturesSection(),
          SizedBox(height: getProportionateScreenHeight(20)),
          const TshirtsSection(),
          SizedBox(height: getProportionateScreenHeight(10)),
          const PantsSections(),
          SizedBox(height: getProportionateScreenHeight(10)),
          const ShoesSection(),
        ],
      ),
    );
  }
}
