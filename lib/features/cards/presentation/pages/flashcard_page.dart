import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_app_bar.dart';
import 'package:notenova/features/autorization/data/firebase_service.dart';
import '../../../../core/style/c_colors.dart';
import '../../../../core/widgets/congratulations_dialog.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/entities/flashcard_stack.dart';
import '../tiles/flashcard_tile.dart';

class FlashcardPage extends StatefulWidget {
  final CardStack _cardStack;
  final void Function(BuildContext context) _goBack;

  const FlashcardPage(this._cardStack, this._goBack, {super.key});

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  List<Flashcard> _flashcardList = [];
  int _currentFlashcard = 0;

  int _wellLearnedCards = 0;
  int _needRepeatCards = 0;

  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _flashcardList = widget._cardStack.cardsList;
  }

  void nextFlashCard() {
    if (_currentFlashcard < _flashcardList.length - 1) {
      _currentFlashcard++;
    } else {
      FirebaseServiceAuth.updateUserXP(_wellLearnedCards);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => CongratulationsDialog(
          title: 'Congratulations 🎉',
          content: 'This stack is finished! \nYour results are '
              '$_wellLearnedCards/${_flashcardList.length}',
          actionText: 'Back to card stacks',
          // goBack: widget._goBack
          goBack: (dialogContext) {
            Navigator.of(dialogContext).pop();
            widget._goBack(context);
          }
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      child: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: CColors.accent,
              body: SizedBox(
                height: height,
                width: width,
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 15 * 2,
                      child: CustomAppBar(
                        screenHeight: height,
                        title: widget._cardStack.name,
                        onPressedBack: () {
                          widget._goBack(context);
                        },
                      ),
                    ),
                    Container(
                      // color: Colors.cyanAccent.withOpacity(0.1),
                      height: height / 15,
                      alignment: Alignment.center,
                      child: Text(
                        "${_wellLearnedCards + _needRepeatCards}/${_flashcardList.length}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Container(
                      // color: Colors.orange.withOpacity(0.1),
                      height: height / 15,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: CColors.transparentPink,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              boxShadow: neumorphismShadowSmallCard
                            ),
                            width: width / 6,
                            alignment: Alignment.center,
                            child: Text("$_needRepeatCards"),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: CColors.primary,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                              ),
                              boxShadow: neumorphismShadowSmallCard
                            ),
                            width: width / 6,
                            alignment: Alignment.center,
                            child: Text("$_wellLearnedCards"),
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
                              nextFlashCard();
                            }
                            _offset = Offset.zero;
                          });
                        },
                        child: Transform.translate(
                          offset: _offset,
                          child: SizedBox(
                              height: height / 5 * 4,
                              child: _flashcardList.isEmpty
                                  ? const Text("sorry, cannot load your cards :(")
                                  : FlashcardTile(_flashcardList[_currentFlashcard])
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
