import 'package:flutter/material.dart';

class Commercials extends StatelessWidget {
  const Commercials({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              height: 300,
              margin: const EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/sneakers.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            Container(
              height: 300,
              margin: const EdgeInsets.only(left: 8, right: 8),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '50%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.grey,
                    child: const Text(
                      'Special Offer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Summer \n Sale'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Shop Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        // Stack(
        //   children: [
        //     Container(
        //       height: 180,
        //       margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        //       decoration: BoxDecoration(
        //         image: DecorationImage(
        //           image: const AssetImage('assets/images/download.jpg'),
        //           fit: BoxFit.cover,
        //           colorFilter: ColorFilter.mode(
        //             Colors.black.withOpacity(0.3),
        //             BlendMode.darken,
        //           ),
        //         ),
        //       ),
        //     ),
        //     Container(
        //       height: 180,
        //       margin: const EdgeInsets.all(8),
        //       padding: const EdgeInsets.all(8),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Container(
        //             padding: const EdgeInsets.all(8),
        //             color: Colors.grey,
        //             child: const Text(
        //               '10% Off',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 16,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ),
        //           Text(
        //             'Wednesday'.toUpperCase(),
        //             style: const TextStyle(
        //               color: Colors.white,
        //               fontSize: 24,
        //               fontWeight: FontWeight.w900,
        //             ),
        //           ),
        //           Text(
        //             'Deal'.toUpperCase(),
        //             style: const TextStyle(
        //               color: Colors.white,
        //               fontSize: 24,
        //               fontWeight: FontWeight.w900,
        //             ),
        //           ),
        //           // const SizedBox(height: 5),
        //           const Text(
        //             'Collections',
        //             // textAlign: TextAlign.center,
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 16,
        //               fontWeight: FontWeight.normal,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 300,
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/sneak_pink.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            Container(
              height: 300,
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '50%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.grey,
                    child: const Text(
                      'Seasonal Deal  ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Upcomin \n Deal'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Shop Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
