import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/datasource/c_colors.dart';

class FlashCard extends StatefulWidget {
  final String term;
  final String definition;

  const FlashCard(this.term, this.definition, {super.key});

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> with SingleTickerProviderStateMixin {
  bool isTermUp = true;
  double scaleX = 1.0;

  late AnimationController _controller;
  late Animation<double> _flipCurve;
  late Animation _flipAnimation;
  AnimationStatus _status = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this
    );

    _flipCurve = CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);

    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(_flipCurve);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      _status = status;
    });
  }

  void flipFlashCard() {
    setState(() {
      isTermUp = !isTermUp;
    });
  }

  void flipText() {
    if (scaleX == 1) {
      scaleX = -1.0;
    } else {
      scaleX = 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: InkWell(
        onTap: () {
          if (_status == AnimationStatus.dismissed) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
          Future.delayed(const Duration(milliseconds: 250)).then((value) {
            flipFlashCard();
            flipText();
          });
        },
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(2, 1, 0.0050)
            ..rotateY(pi * _flipAnimation.value),
          alignment: Alignment.center,
          child: Align(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: 200,
                width: 300,
                color: CColors.primary,
                alignment: Alignment.center,
                child: Transform(
                  transform: Matrix4.identity()..scale(scaleX, 1.0, 1.0),
                  alignment: Alignment.center,
                  child: Text(
                    isTermUp ? widget.term : widget.definition,
                    style: const TextStyle(
                      color: CColors.textDark
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}