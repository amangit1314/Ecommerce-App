// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../utils/size_config.dart';

// class CustomAppBar extends StatefulWidget implements PreferredSize {
//   final double rating;
//   CustomAppBar({Key? key, Key? key},required this.rating) : super(key: key), super(key = key);

//   @override
//   Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

//   @override
//   _CustomAppBarState createState() => _CustomAppBarState();
// }

// class _CustomAppBarState extends State<CustomAppBar>{
//   @override
//   Widget build(BuildContext context){
//     return  SafeArea(
//     child: Padding(
//     padding:
//     EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//     child: Row(
//     children: [
//     SizedBox(
//     height: getProportionateScreenWidth(40),
//     width: getProportionateScreenWidth(40),
//     child: FlatButton(
//     shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(60),
//     ),
//     color: Colors.white,
//     padding: EdgeInsets.zero,
//     onPressed: () => Navigator.pop(context),
//     child: SvgPicture.asset(
//     "assets/icons/Back ICon.svg",
//     height: 15,
//     ),
//     ),
//     ),
//     const Spacer(),
//     Container(
//     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
//     decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(14),
//     ),
//     child: Row(
//     children: [
//     Text(
//     "$rating",
//     style: const TextStyle(
//     fontSize: 14,
//     fontWeight: FontWeight.w600,
//     ),
//     ),
//     const SizedBox(width: 5),
//     SvgPicture.asset("assets/icons/Star Icon.svg"),
//     ],
//     ),
//     )
//     ],
//     ),
//     ),
//     );
//     }
//   }
//   }
// }


