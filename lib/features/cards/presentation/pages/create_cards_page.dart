import 'package:flutter/material.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/cards/data/firebase_service.dart';
import 'package:notenova/features/cards/presentation/pages/flashcard_page.dart';
import 'package:notenova/features/cards/presentation/widgets/light_rounded_bg.dart';

import '../../../../core/style/c_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../main.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/entities/flashcard_stack.dart';
import '../tiles/card_editing_tile.dart';

class CreateCardsPage extends StatefulWidget {
  final CardStack cardStack;

  const CreateCardsPage(this.cardStack, {super.key});

  @override
  State<CreateCardsPage> createState() => _CreateCardsPageState();
}

class _CreateCardsPageState extends State<CreateCardsPage> {
  int _numCards = 1;
  List<Flashcard> cardList = [Flashcard('', '')];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - bottomNavBarHeight;
    double lightRoundedBGHeight = (height - 30) / 15 * 13;

    return Scaffold(
      backgroundColor: CColors.accent,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: height + bottomNavBarHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: height / 15 * 2,
              child: CustomAppBar(
                screenHeight: height,
                title: widget.cardStack.name,
                onPressedBack: () {
                  Navigator.of(context).pop();
                },
              ),
            ),

            LightRoundedBG(
              height: lightRoundedBGHeight + bottomNavBarHeight,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: SizedBox(
                  height: lightRoundedBGHeight - 60, // 60 = padding
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.white, Colors.transparent, Colors.transparent, Colors.white],
                            stops: [0.0, 0.1, 0.9, 1.0], // 10% purple, 80% transparent, 10% purple
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstOut,
                        child: SizedBox(
                          height: (lightRoundedBGHeight - 60) / 7 * 6,
                          child: ListView.builder(
                            // padding: EdgeInsets.zero(),
                            itemCount: _numCards + 1,
                            itemBuilder: (context, index) {
                              // "Add a new card" button
                              if (index == _numCards) {
                                return  Padding(
                                  padding: const EdgeInsets.only(bottom: 100),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor,
                                      boxShadow: neumorphismShadowSmallCard
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          _numCards++;
                                          cardList.add(Flashcard('', ''));
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }

                              return CardEditingTile(cardList, index);
                            }
                          ),
                        ),
                      ),
                      CustomButton(
                        text: 'Start learning',
                        onPressed: () {
                          widget.cardStack.cardsList = cardList;
                          FirebaseService.addCardStack(widget.cardStack);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FlashcardPage(
                                widget.cardStack,
                                (context) {
                                  Navigator.of(context)..pop()..pop()..pop();
                                }
                              )
                            )
                          );
                        }
                      ),
                      // const SizedBox(height: bottomNavBarHeight,),
                    ],
                  ),
                ),
              )
            ),

          ],
        ),
      ),
    );
  }
}
