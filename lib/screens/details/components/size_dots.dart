import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class SizeDots extends StatefulWidget {
  const SizeDots({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<SizeDots> createState() => _SizeDotsState();
}

class _SizeDotsState extends State<SizeDots> {
  int selectedSize = 0;

  List<String> sizes = ['M', 'L', 'XL', 'XXL'];

  @override
  Widget build(BuildContext context) {
    List<String>? productSizes = widget.product.sizes;

    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        children: [
          ...(productSizes != null
                  ? List.generate(
                      productSizes.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(5),
                          width: getProportionateScreenWidth(40),
                          height: getProportionateScreenWidth(40),
                          decoration: BoxDecoration(
                            color: selectedSize == index
                                ? kPrimaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: selectedSize == index
                                  ? Colors.transparent
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              productSizes[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: selectedSize == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : sizes.map(
                      (size) => GestureDetector(
                        onTap: () {
                          // Handle size selection
                          setState(() {
                            selectedSize = sizes.indexOf(size);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(5),
                          width: getProportionateScreenWidth(40),
                          height: getProportionateScreenWidth(40),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              size,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
              .toList(),
        ],
      ),
    );
  }
}
