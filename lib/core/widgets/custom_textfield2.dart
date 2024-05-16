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
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLength;

  const MyCustomTextField({
    super.key,
    required this.baseColor,
    this.width,
    this.height = 55,
    this.maxLines,
    this.onChanged,
    this.onSubmitted,
    this.title,
    this.controller,
    this.hintText,
    this.maxLength,
    this.gradientColor = const Color(0xffCCD9E4),
  });

  @override
  Widget build(BuildContext context) {
    return title != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  Text(title!, style: Theme.of(context).textTheme.bodySmall),
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
                controller: controller,
                hintText: hintText,
                maxLength: maxLength,
              ),
            ],
          )
        : BoxItself(
            baseColor: baseColor,
            width: width,
            height: height,
            maxLines: maxLines,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            gradientColor: gradientColor,
            controller: controller,
            hintText: hintText,
            maxLength: maxLength,
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
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLength;

  const BoxItself({
    super.key,
    required this.baseColor,
    this.width,
    this.height,
    this.maxLines,
    this.onChanged,
    this.onSubmitted,
    this.title,
    this.hintText,
    this.controller,
    this.maxLength,
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
          left: 15,
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
          left: 15,
          top: 1,
          right: 5,
          bottom: 7.5,
          child: TextField(
            controller: controller,
            onChanged: (value) {
              if (onChanged != null) {
                onChanged!(value);
              }
            },
            onSubmitted: (value) {
              if (onSubmitted != null) {
                onSubmitted!(value);
              }
            },
            cursorColor: gradientColor,
            maxLines: maxLines,
            maxLength: maxLength,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              errorBorder: InputBorder.none,
              errorStyle: TextStyle(height: 0),
            ),
          ),
        ),
      ],
    );
  }
}
