import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/features/quizzes/presentation/quiz_card.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

final List<Quiz> _quizList = [
  Quiz(
      title: 'Pomodoro technique',
      category: 'Productivity',
      description:
          'The Pomodoro Technique is a time management method developed by Francesco Cirillo in the late 1980s. The technique uses a timer to break down work into intervals, traditionally 25 minutes in length, separated by short breaks.',
      image:
          'https://www.float.com/static/1bfc987d080e931e9a1ceacfe0369c55/94ec29bc-c298-437b-86df-c2a66f005e27_engaging+stakeholders.png'),
  Quiz(
      title: 'Java',
      category: 'Code',
      description:
          'Java is a class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible.',
      image:
          'https://www.float.com/static/1bfc987d080e931e9a1ceacfe0369c55/94ec29bc-c298-437b-86df-c2a66f005e27_engaging+stakeholders.png'),
  Quiz(
      title: 'Java',
      category: 'Code',
      description:
      'Java is a class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible.',
      image:
      'https://www.float.com/static/1bfc987d080e931e9a1ceacfe0369c55/94ec29bc-c298-437b-86df-c2a66f005e27_engaging+stakeholders.png'),
  Quiz(
      title: 'Java',
      category: 'Code',
      description:
      'Java is a class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible.',
      image:
      'https://www.float.com/static/1bfc987d080e931e9a1ceacfe0369c55/94ec29bc-c298-437b-86df-c2a66f005e27_engaging+stakeholders.png'),
  Quiz(
      title: 'Java',
      category: 'Code',
      description:
      'Java is a class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible.',
      image:
      'https://www.float.com/static/1bfc987d080e931e9a1ceacfe0369c55/94ec29bc-c298-437b-86df-c2a66f005e27_engaging+stakeholders.png'),
];

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
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(
                      left: 20, top: constraints.maxHeight - 70),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(LocaleKeys.quizzes.tr(),
                          style: Theme.of(context).textTheme.bodyLarge),
                      Text(LocaleKeys.check_your_knowledge.tr(),
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  background: ColoredBox(color: Theme.of(context).primaryColor),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
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
                        CustomButton(
                          text: 'Category',
                          onPressed: () {},
                          gradient: LinearGradient(
                            colors: CColors.pinkGradientColor,
                          ),
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
                   return QuizCard(
                     quiz: _quizList[index],
                   );
                 },
                 childCount: 4,
               ),
         ),
        ],
      ),
    );
  }
}

