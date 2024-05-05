import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notenova/features/cards/data/firebase_service.dart';
import 'package:notenova/features/cards/presentation/widgets/card_stack_tile.dart';

class CardStackList extends StatelessWidget {
  const CardStackList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseService.getCardStackStream(),
      builder: (context, snapshot) {

        List cardStackList = snapshot.data?.docs ?? [];
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        // TODO: remove this!!!
        cardStackList = [...cardStackList, ...cardStackList, ...cardStackList];


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
            padding: const EdgeInsets.only(top: 30),
            itemCount: cardStackList.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = cardStackList[index];
              // getting a single card stack
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

              // outputs card stack's info (for testing)
              List<dynamic> cards = data['cards'] as List<dynamic>;
              // print(data['name']);
              // for(var card in cards) {
              //   print("$card");
              // }

              return CardStackTile(data['name'], cards.length);
            },
          ),
        );

      }
    );
  }
}
