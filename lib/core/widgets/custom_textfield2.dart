import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';


class MyCustomTextField extends StatelessWidget {
  final Color gradientColor;
  final Color baseColor;
  final double? width;
  final double? height;
  final int? maxLines;
  final Function? onChanged;
  final Function? onSubmitted;
  final String? title;


  const MyCustomTextField({super.key,
    required this.baseColor,
    this.width,
    this.height = 55,
    this.maxLines,
    this.onChanged,
    this.onSubmitted,
    this.title,
    this.gradientColor = const Color(0xffCCD9E4),
  });

  @override
  Widget build(BuildContext context) {
    return title!= null ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Text(title!,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            midSizedBoxHeight,
            BoxItself(
              baseColor: baseColor,
              width: width,
              height: height,
              maxLines: maxLines,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              gradientColor: gradientColor,
            ),
          ],
        ):
        BoxItself(
          baseColor: baseColor,
          width: width,
          height: height,
          maxLines: maxLines,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          gradientColor: gradientColor,
        );
  }
}

class BoxItself extends StatelessWidget {
  final Color gradientColor;
  final Color baseColor;
  final double? width;
  final double? height;
  final int? maxLines;
  final Function? onChanged;
  final Function? onSubmitted;
  final String? title;


  const BoxItself({super.key,
    required this.baseColor,
    this.width,
    this.height,
    this.maxLines,
    this.onChanged,
    this.onSubmitted,
    this.title,
    this.gradientColor = const Color(0xffA5C0D7),
  });

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          width: width,
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
            width: width,
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
        Positioned(
          left:15,
          top:1,
          right: 5,
          bottom: 7.5,
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
            maxLines: maxLines,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

