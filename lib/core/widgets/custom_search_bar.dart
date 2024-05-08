import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notenova/core/utils/constants.dart';

double searchBarHeight = 60;


class CustomSearchBar extends StatelessWidget {
  final Color gradientColor;
  final Color baseColor;
  final double? height;
  final Function? onChanged;
  final Function? onSubmitted;


  const CustomSearchBar({super.key,
    required this.baseColor,
    this.height = 55,
    this.onChanged,
    this.onSubmitted,
    this.gradientColor = const Color(0xffCCD9E4),
  });

  @override
  Widget build(BuildContext context) {
    return ShadedBox(
      baseColor: baseColor,
      height: height,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      gradientColor: gradientColor,
    );
  }
}

class ShadedBox extends StatelessWidget {
  final Color gradientColor;
  final Color baseColor;
  final double? height;
  final Function? onChanged;
  final Function? onSubmitted;


  const ShadedBox({super.key,
    required this.baseColor,
    this.height,
    this.onChanged,
    this.onSubmitted,
    this.gradientColor = const Color(0xffA5C0D7),
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 60,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gradientColor, baseColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              color: gradientColor,
              border: Border.all(
                color: gradientColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Positioned(
            left:15,
            top: 10,
            right: 5,
            bottom: 7.5,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: baseColor,
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (value) {
                  if (onChanged != null){
                    onChanged!(value);}
                },
                onSubmitted: (value) {
                  if (onSubmitted != null){
                    onSubmitted!(value);}
                },
                cursorColor: gradientColor,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).textTheme.bodyMedium?.color
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// class CustomSearchBar extends StatelessWidget {
//   final double width;
//
//   const CustomSearchBar(this.width, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     double availableWidth = width;
//
//     return Container(
//       decoration: BoxDecoration(boxShadow: shadowCard),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Align(
//           child: Container(
//             width: availableWidth,
//             color: Colors.white,
//             padding: const EdgeInsets.symmetric(vertical: 15),
//             alignment: Alignment.center,
//             height: searchBarHeight,
//             child: TextField(
//               style: Theme.of(context).textTheme.bodyMedium,
//               // decoration: InputDecoration.collapsed(hintText: "searching for..."),
//               decoration: const InputDecoration(
//                 isCollapsed: true,
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: Colors.grey,
//                 ),
//                 enabledBorder: InputBorder.none,
//                 focusedBorder: InputBorder.none
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
