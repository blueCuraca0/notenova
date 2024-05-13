import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/features/quizzes/presentation/taking_quizzes/check_block.dart';

class CheckAnswers extends StatelessWidget {
  final int indexQuiz;

  const CheckAnswers({super.key, required this.indexQuiz});

  Quiz getQuiz(BuildContext context, int index){
    return context.read<QuizCubit>().currentQuiz(index);
  }

  bool isCorrect(BuildContext context, int indexQuestion){
     for (int i = 0; i < getQuiz(context, indexQuiz).questions[indexQuestion].options.length; i++){
       if (context.read<QuizCubit>().checkBoxType(indexQuiz, i, indexQuestion) == 'red'){
         return false;
       }
     }
     return true;
  }

  String getScore(BuildContext context, int index){
    int correctAnswers = 0;
    for (int i = 0; i < getQuiz(context, index).questions.length; i++){
      if (isCorrect(context, i)){
        correctAnswers++;
      }
    }
    return '$correctAnswers/${getQuiz(context, index).questions.length}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
           automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).cardColor,
            expandedHeight: MediaQuery.of(context).size.height*0.15,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network('https://images.pexels.com/photos/301920/pexels-photo-301920.jpeg?cs=srgb&dl=pexels-pixabay-301920.jpg&fm=jpg',
                fit: BoxFit.cover,),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: lPadding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
                   child:   Text('${LocaleKeys.your_results.tr()} ${getScore(context, indexQuiz)}', //TODO: hardcoded string
                          style: Theme.of(context).textTheme.bodyLarge),
              ),
            ),
          SliverList(delegate:
          SliverChildBuilderDelegate((BuildContext context, int index){
            return Padding(
              padding: lPadding,
              child: CheckBlock(indexQuestion: index, indexQuiz: indexQuiz),
            );
          },
            childCount: getQuiz(context, indexQuiz).questions.length,
          ),
          ),
          SliverToBoxAdapter(
              child:
              Padding(
                padding: lPadding,
                child: CustomButton(text: LocaleKeys.back.tr(), onPressed: (){
                  for (int i = 0; i < getQuiz(context, indexQuiz).questions.length; i++){
                    Navigator.pop(context);
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                }),
              )),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}