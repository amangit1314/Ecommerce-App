import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/product.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import 'components/body.dart';

// class DetailsScreen extends StatelessWidget {
//   final Product product;
//   const DetailsScreen({Key? key, required this.product}) : super(key: key);
//   static String routeName = "/details";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F6F9),
//       body: Body(product: product),
//     );
//   }
// }

class DetailsScreenFirebase extends StatelessWidget {
  final Product product;
  const DetailsScreenFirebase({Key? key, required this.product})
      : super(key: key);
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments? args =
        ModalRoute.of(context)?.settings.arguments as ProductDetailsArguments?;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: SizedBox(
            height: getProportionateScreenWidth(40),
            width: getProportionateScreenWidth(40),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                backgroundColor: Colors.white,
                padding: EdgeInsets.zero,
              ),
              onPressed: () => Navigator.pop(context),
              child: SvgPicture.asset(
                "assets/icons/Back ICon.svg",
                height: 15,
              ),
            ),
          ),
          title: Text(
            product.title,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Text(
                    "${args?.product.rating}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset("assets/icons/Star Icon.svg"),
                ],
              ),
            ),
          ],
        ),
      ),
      // backgroundColor: const Color(0xFFF5F6F9),
      backgroundColor: Colors.white,
      body: DetailFirebaseBody(product: product),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
