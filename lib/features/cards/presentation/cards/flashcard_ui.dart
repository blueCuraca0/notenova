import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/cards/domain/entities/flashcard.dart';
import '../../../../core/style/c_colors.dart';

class FlashcardUI extends StatefulWidget {
  final Flashcard flashcard;

  const FlashcardUI(this.flashcard, {super.key});

  @override
  State<FlashcardUI> createState() => _FlashcardUIState();
}

class _FlashcardUIState extends State<FlashcardUI> with SingleTickerProviderStateMixin {
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
                  // color: CColors.primary,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: shadowCard,
                    color: CColors.primary,
                  ),
                  child: Transform(
                    transform: Matrix4.identity()..scale(scaleX, 1.0, 1.0),
                    alignment: Alignment.center,
                    child: Text(
                      isTermUp ? widget.flashcard.term : widget.flashcard.definition,
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