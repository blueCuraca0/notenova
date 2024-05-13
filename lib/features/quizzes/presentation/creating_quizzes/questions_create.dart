import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/presentation/creating_quizzes/question_dialog.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';
import 'package:notenova/features/quizzes/presentation/creating_quizzes/widgets/single_question_block.dart';

import '../../../autorization/data/firebase_service.dart';
import 'package:notenova/features/quizzes/presentation/button_back.dart';


class QuestionCreate extends StatelessWidget {
  const QuestionCreate({super.key});

  Future<void> addNewQuiz(BuildContext context, Quiz quiz) async{
    await context.read<QuizCubit>().addQuiz(quiz);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        if (state is QuizChanged){
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: const ButtonBack(),
                leadingWidth: 100,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(LocaleKeys.add_questions.tr(),
                              style: Theme.of(context).textTheme.bodyLarge),
                          spacer,
                          FloatingActionButton(onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => QuestionDialog(title: LocaleKeys.choose_the_type_of_ques.tr(),
                                  button1: LocaleKeys.single.tr(),
                                  button2: LocaleKeys.multiple.tr(),
                                  button1Action: (){
                                    context.read<QuizCubit>().singleQuestionCreate();
                                  },
                                  button2Action: (){
                                    context.read<QuizCubit>().multipleQuestionCreate();
                                  },
                                ),
                                barrierDismissible: true
                            );
                          },
                          backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                     midSizedBoxHeight,
                    ],
                  ),
                ),
              ),
              SliverList(delegate:
              SliverChildBuilderDelegate((BuildContext context, int index){
                  return Padding(
                    padding: lPadding,
                    child: QuestionBlock(index: index,),
                  );
                },
                  childCount: state.newQuiz!.questions.length,
                ),
              ),
              SliverToBoxAdapter(
                  child:
                  Padding(
                    padding: lPadding,
                    child: CustomButton(text: LocaleKeys.create_new_quiz.tr(), onPressed: ()async {
                      await addNewQuiz(context, state.newQuiz!);
                      FirebaseServiceAuth.updateUserXP(standardXP);
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
        );}
        else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }
    );
  }
}