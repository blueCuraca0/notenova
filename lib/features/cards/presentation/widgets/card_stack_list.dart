import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notenova/features/cards/data/firebase_service.dart';
import 'package:notenova/features/cards/presentation/tiles/card_stack_tile.dart';

import '../../data/models/flashcard_stack_model.dart';
import '../../domain/entities/flashcard_stack.dart';

class CardStackList extends StatelessWidget {
  const CardStackList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseService.getCardStackStream(),
      builder: (context, snapshot) {

        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox();
        }

        List cardStackList = snapshot.data?.docs ?? [];

        return ShaderMask(
          shaderCallback: (Rect rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.transparent, Colors.transparent, Colors.white],
              stops: [0.0, 0.1, 0.9, 1.0], // 10% purple, 80% transparent, 10% purple
            ).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 100),
            itemCount: cardStackList.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = cardStackList[index];
              // getting a single card stack
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              CardStack cardStack = CardStackModel.cardStackFromJson(data);

              return CardStackTile(cardStack);
            },
          ),
        );

      }
    );
  }
}
