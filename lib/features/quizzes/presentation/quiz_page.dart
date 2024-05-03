import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';

class QuizPage extends StatelessWidget {
  final expandedHeight = 200.0;

  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
         SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.2,
            floating: true,
            pinned: false,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: 20, top: constraints.maxHeight-70),
                  title: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Quizzes',
                                style: TextStyle(
                                  color: CColors.text,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lato',
                                )),
                            Text('Check your knowledge!',
                                style: TextStyle(
                                  color: CColors.text,
                                  fontSize: 16,
                                  fontFamily: 'Lato',
                                )),
                          ],
                        ),
                  background: ColoredBox(color: CColors.accent),
                );
              },
              ),
            ),
           SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: CColors.accentSoft,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    children: [
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                    midSizedBoxHeight,
                    Row(
                      children: [
                        Container(
                          padding: smallPadding,
                          decoration: BoxDecoration(
                            color: CColors.accentSoft,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('Category'),
                        ),
                      ],
                    ),
                  ],
                  ),
                ),
              ),
            ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  height: 100,
                  color: index.isEven ? Colors.white : Colors.black12,
                  child: Center(
                    child: Text('Quiz $index'),
                  ),
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
