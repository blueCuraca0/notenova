import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_search_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';

import '../../../../core/utils/languages/generated/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/features/quizzes/domain/entities/category.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';
import 'package:notenova/features/quizzes/presentation/creating_quizzes/questions_create.dart';

class QuizLayout extends StatelessWidget {
  const QuizLayout({super.key});

  List<Category> getCategories(BuildContext context) {
    return context.read<QuizCubit>().categories;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColor,
              expandedHeight: height * 0.08,
              title: Text(LocaleKeys.create_new_quiz.tr(),
              style: Theme.of(context).textTheme.bodyLarge),
              pinned: true,
              flexibleSpace: const FlexibleSpaceBar(
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Theme.of(context).cardColor,
                padding: lPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [

                        ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              height: height * 0.2,
                              width: width * 0.3,
                              state.newQuiz!.image,
                            fit: BoxFit.cover,),
                          ),

                        bigSizedBoxWidth,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            midSizedBoxHeight,
                            MyCustomTextField(
                              baseColor: Theme.of(context).cardColor,
                              width: width * 0.5,
                              title: LocaleKeys.title.tr(),
                              onChanged: (value) {
                                context.read<QuizCubit>().changeTitle(value);
                              },
                            ),
                            bigSizedBoxHeight,
                            TextButton(onPressed: (){}, child: Text(
                              LocaleKeys.change_pic.tr(), //TODO: change_pic change
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            )), //TODO: images from gallery
                          ],
                        ),
                      ],
                    ),
                    bigSizedBoxHeight,
                    MyCustomTextField(
                        baseColor: Theme.of(context).cardColor,
                        title: LocaleKeys.description.tr(),
                        maxLines: 5,
                        height: height * 0.2,
                        onChanged: (value) {
                          context.read<QuizCubit>().changeDescription(value);
                        }),
                    bigSizedBoxHeight,
                    Text(LocaleKeys.category.tr(),
                        style: Theme.of(context).textTheme.bodySmall),
                    bigSizedBoxHeight,
                    Container(
                      height: height * 0.07,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: getCategories(context).length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              CustomButton(
                                text: getCategories(context)[index].name,
                                onPressed: () {
                                    context.read<QuizCubit>().changeCategory(getCategories(context)[index]);
                                },
                                gradient: LinearGradient(
                                  colors:
                                      getCategories(context)[index].gradient,
                                ),
                              ),
                              midSizedBoxWidth,
                            ],
                          );
                        },
                      ),
                    ),
                    bigSizedBoxHeight,
                    midSizedBoxHeight,
                    BlocBuilder<QuizCubit, QuizState>(
                      builder: (context, state) {
                        return CustomButton(
                            text: 'Go to questions',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const QuestionCreate()));
                            });
                      },
                    ) , //TODO: Hardcoded string remove
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}