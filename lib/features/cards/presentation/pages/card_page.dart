import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/cards/data/models/flashcard_stack_model.dart';
import 'package:notenova/features/cards/data/firebase_service.dart';
import '../../../../core/style/c_colors.dart';
import '../../domain/entities/flashcard.dart';
import '../cards/flashcard_ui.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  List<Flashcard> _flashcardList = [];
  int _currentFlashcard = 0;

  int _wellLearnedCards = 0;
  int _needRepeatCards = 0;

  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _flashcardList = [
      const Flashcard("T E R M    1", "D E F I N I T I O N    1"),
      const Flashcard("T E R M    2", "D E F I N I T I O N    2"),
      const Flashcard("T E R M    3", "D E F I N I T I O N    3"),
      const Flashcard("T E R M    4", "D E F I N I T I O N    4"),
      const Flashcard("T E R M    5", "D E F I N I T I O N    5"),
      const Flashcard("T E R M    6", "D E F I N I T I O N    6"),
    ];
  }

  void nextFlashCard() {
    if (_currentFlashcard < _flashcardList.length - 1) {
      _currentFlashcard++;
    } else {
      _currentFlashcard = 0;
      // TODO: show that user had finished this stack
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Material(
            child: Scaffold(
              backgroundColor: CColors.accentSoft,
              body: Stack(
                alignment: Alignment.center,
                children: [
                  // card ui
                  SizedBox(
                    height: height,
                    width: width,
                    child: Column(
                      children: [
                        Container(
                          // color: Colors.purple.withOpacity(0.1),
                          height: height / 15 * 2,
                          alignment: Alignment.bottomCenter,
                          child: const Text(
                            "Card Stack's name",
                            style: TextStyle(
                                fontSize: 25,
                                color: CColors.textDark,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          // color: Colors.cyanAccent.withOpacity(0.1),
                          height: height / 15,
                          alignment: Alignment.center,
                          child: Text(
                            "${_wellLearnedCards + _needRepeatCards}/${_flashcardList.length}",
                            style: const TextStyle(
                              // fontSize: 25,
                              color: CColors.textDark,
                              // fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Container(
                          // color: Colors.orange.withOpacity(0.1),
                          height: height / 15,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: CColors.transparentPink,
                                    // boxShadow: shadowCard
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: CColors.text.withOpacity(0.1),
                                    //     spreadRadius: 5,
                                    //     blurRadius: 7,
                                    //     offset: const Offset(0, 3),
                                    //   ),
                                    // ]
                                  ),
                                  width: width / 6,
                                  alignment: Alignment.center,
                                  child: Text("$_needRepeatCards"),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                ),
                                child: Container(
                                  color: CColors.primary,
                                  width: width / 6,
                                  alignment: Alignment.center,
                                  child: Text("$_wellLearnedCards"),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          // color: Colors.red.withOpacity(0.2),
                          height: height / 15 * 11,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              setState(() {
                                _offset += details.delta;
                              });
                            },
                            onPanEnd: (details) {
                              setState(() {
                                if ((_offset.dx).abs() > width / 4) {
                                  if (_offset.dx > 0) {
                                    _wellLearnedCards++;
                                  } else {
                                    _needRepeatCards++;
                                  }
                                }
                                nextFlashCard();
                                _offset = Offset.zero;
                              });
                            },
                            child: Transform.translate(
                              offset: _offset,
                              child: SizedBox(
                                  height: height / 5 * 4,
                                  child: FlashcardUI(_flashcardList[_currentFlashcard])
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // TODO: appbar, navbar etc.
                ],
              ),
            ),
          );
        });
  }
}
