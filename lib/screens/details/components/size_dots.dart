import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';
import '../../../providers/product_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class SizeDots extends StatefulWidget {
  const SizeDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<SizeDots> createState() => _SizeDotsState();
}

class _SizeDotsState extends State<SizeDots> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
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
                          productProvider
                              .updateSelectedSize(productSizes[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(5),
                          width: getProportionateScreenWidth(44),
                          height: getProportionateScreenWidth(44),
                          decoration: BoxDecoration(
                            color: productProvider.selectedSize ==
                                    productSizes[index]
                                ? kPrimaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              width: productProvider.selectedSize ==
                                      productSizes[index]
                                  ? 0
                                  : 2,
                              color: productProvider.selectedSize ==
                                      productSizes[index]
                                  ? Colors.transparent
                                  : kPrimaryColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              productSizes[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: productProvider.selectedSize ==
                                        productSizes[index]
                                    ? Colors.white
                                    : kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : productSizes!.map(
                      (size) => GestureDetector(
                        onTap: () {
                          productProvider.updateSelectedSize(size);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(8),
                          width: getProportionateScreenWidth(44),
                          height: getProportionateScreenWidth(44),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              size,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
