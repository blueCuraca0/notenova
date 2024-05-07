import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';
import 'package:notenova/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';
import 'package:notenova/features/quizzes/domain/entities/quiz.dart';


class QuestionCreate extends StatelessWidget {
  const QuestionCreate({Key? key}) : super(key: key);

  void addNewQuiz(BuildContext context, Quiz quiz) {
    context.read<QuizCubit>().addQuiz(quiz);
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
                backgroundColor: Theme.of(context).cardColor,
                expandedHeight: MediaQuery.of(context).size.height*0.15,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(state.newQuiz!.image,
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
                          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add),
                          backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ],
                      ),
                     midSizedBoxHeight,
                    ],
                  ),
                ),
              ),
              SliverList(delegate:SliverChildBuilderDelegate((BuildContext context, int index){
                  return Padding(
                    padding: lPadding,
                    child: QuestionBlock(),
                  );
                },
                  childCount: 5,
                ),
              ),
              SliverToBoxAdapter(
                  child:
                  Padding(
                    padding: lPadding,
                    child: CustomButton(text: LocaleKeys.create_new_quiz.tr(), onPressed: (){
                      addNewQuiz(context, state.newQuiz!);
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

class QuestionBlock extends StatelessWidget {
  const QuestionBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: lPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyCustomTextField(
            baseColor: Theme.of(context).cardColor,
            hintText: LocaleKeys.question.tr(),
          ),
          midSizedBoxHeight,
          QuestionRow(),
          midSizedBoxHeight,
          QuestionRow(),
          midSizedBoxHeight,
          TextButton(onPressed: (){}, child: Text("+ ${LocaleKeys.add_option.tr()}",
          style: Theme.of(context).textTheme.bodySmall
          ),),
        ],
      ),
    );
  }
}

class QuestionRow extends StatelessWidget{
  const QuestionRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckBox(),
        midSizedBoxWidth,
        Expanded(
          child: MyCustomTextField(
            baseColor: Theme.of(context).cardColor,
            hintText: LocaleKeys.option.tr(),
          ),
        ),
        midSizedBoxWidth,
        GestureDetector(onTap: (){},
          child: const Icon(Icons.delete_outline),),
      ],
    );
  }
}

class CustomCheckBox extends StatefulWidget{
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).cardColor;

    return InkWell(
      onTap: (){
        setState(() {
          color = color == Theme.of(context).cardColor ? Theme.of(context).primaryColor : Theme.of(context).cardColor;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children:[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Theme.of(context).primaryColorDark,
                width: 2,
              ),
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}