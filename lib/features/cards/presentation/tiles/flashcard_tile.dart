import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/cards/domain/entities/flashcard.dart';

class FlashcardTile extends StatefulWidget {
  final Flashcard flashcard;

  const FlashcardTile(this.flashcard, {super.key});

  @override
  State<FlashcardTile> createState() => _FlashcardTileState();
}

class _FlashcardTileState extends State<FlashcardTile> with SingleTickerProviderStateMixin {
  bool isTermUp = true;
  double scaleX = 1.0;
  List<BoxShadow> currentShadow = neumorphismShadowLargeCardLeftLight;

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

  void flipShadow() {
    if (currentShadow == neumorphismShadowLargeCardLeftLight) {
      currentShadow = neumorphismShadowLargeCardRightLight;
    } else {
      currentShadow = neumorphismShadowLargeCardLeftLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: InkWell(
        splashColor: Colors.transparent,
          onTap: () {
            if (_status == AnimationStatus.dismissed) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
            Future.delayed(const Duration(milliseconds: 250)).then((value) {
              flipFlashCard();
              flipText();
              flipShadow();
            });
          },
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(2, 1, 0.0050)
              ..rotateY(pi * _flipAnimation.value),
            alignment: Alignment.center,
            child: Align(
              child: Container(
                height: 350,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow:  currentShadow,
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).cardColor,
                  // color: CColors.darkGreen,
                ),
                child: Transform(
                  transform: Matrix4.identity()..scale(scaleX, 1.0, 1.0),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      isTermUp ? widget.flashcard.term : widget.flashcard.definition,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
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