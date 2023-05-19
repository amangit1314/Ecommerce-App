import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../../utils/constatns.dart';
import '../../../utils/size_config.dart';

class ColorDots extends StatelessWidget {
  const ColorDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      // child: Row(
      //   children: [
      //     StreamBuilder<DocumentSnapshot>(
      //       stream: FirebaseFirestore.instance
      //           .collection('products')
      //           .doc(product.id.toString())
      //           .snapshots(),
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData) {
      //           Map<String, dynamic> data =
      //               snapshot.data!.data() as Map<String, dynamic>;
      //           List<String> colors = List<String>.from(data['colors']);

      child: Row(
        children: const [
          // colors.map((color) {
          //   int index = colors.indexOf(color);
          //   bool isSelected = index == 0 ? true : false;
          //   return
          ColorDot(
            // // convert string to Color
            // color: Color(int.parse(colors[index])),
            color: Colors.blue,
            isSelected: true,
          ),
        ],
      ),
    );
    // }).toList(),
    // ));
  }
}
// } else {
//   return const CircularProgressIndicator();
// }
//       },
//     ),
//     const Spacer(),
//   ],
// ),
//     );
//   }
// }

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(4)),
      height: getProportionateScreenWidth(30),
      width: getProportionateScreenWidth(30),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: isSelected ? kPrimaryColor : Colors.red,
          width: 3,
        ),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
