import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/core/widgets/custom_search_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';

import '../../../core/utils/languages/generated/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/features/quizzes/domain/entities/category.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';

class QuizLayout extends StatelessWidget {
  const QuizLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizCubit>(
      create: (BuildContext context) {
        return QuizCubit();
      },
      child: const _QuizLayout(),
    );
  }
}

class _QuizLayout extends StatelessWidget {
  const _QuizLayout({super.key});

  List<Category> getCategories(BuildContext context) {
    return context.read<QuizCubit>().categories;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: CColors.accent,
            title: Text(LocaleKeys.create_new_quiz.tr()),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).cardColor,
              padding: lPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyCustomTextField(
                      baseColor: Theme.of(context).cardColor,
                      title: LocaleKeys.title.tr()),
                  bigSizedBoxHeight,
                  MyCustomTextField(
                      baseColor: Theme.of(context).cardColor,
                      title: LocaleKeys.description.tr(),
                      maxLines: 5,
                      height: height * 0.2),
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
                              onPressed: () {},
                              gradient: LinearGradient(
                                colors: getCategories(context)[index].gradient,
                              ),
                            ),
                            midSizedBoxWidth,
                          ],
                        );
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(LocaleKeys.add_category.tr(),
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                  bigSizedBoxHeight,
                  BlocBuilder<QuizCubit, QuizState>(
                    builder: (context, state) {
                      return CustomButton(
                          text: 'Go to questions', onPressed: () {});
                    },
                  ) //TODO: Hardcoded string remove
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
