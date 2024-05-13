import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notenova/core/widgets/custom_textfield2.dart';
import 'package:notenova/features/quizzes/domain/entities/question.dart';
import 'package:notenova/features/quizzes/presentation/creating_quizzes/widgets/add_category_dialog.dart';
import 'dart:io';
import '../../../../core/utils/languages/generated/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';
import 'package:notenova/features/quizzes/domain/entities/category.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_states.dart';
import 'package:notenova/features/quizzes/presentation/creating_quizzes/questions_create.dart';
import 'package:notenova/features/quizzes/presentation/button_back.dart';
import 'package:image_picker/image_picker.dart';


class QuizLayout extends StatelessWidget {
  const QuizLayout({super.key});

  List<Category> getCategories(BuildContext context) {
    return context.read<QuizCubit>().categories;
  }

  void addCategory(String name, BuildContext context) {
    context.read<QuizCubit>().addCategory(name);
  }

  void deleteCategory(Category category, BuildContext context) {
    context.read<QuizCubit>().deleteCategory(category);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (!context.read<QuizCubit>().categories.isEmpty) {
      context.read<QuizCubit>().categories[0].isSelected = true;
      context.read<QuizCubit>().changeCategory(context.read<QuizCubit>().categories[0]);
    }
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: const ButtonBack(),
              leadingWidth: 80,
              backgroundColor: Theme.of(context).primaryColor,
              expandedHeight: height * 0.08,
              title: Text(LocaleKeys.create_new_quiz.tr(),
                    style: Theme.of(context).textTheme.bodyLarge),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: lPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: (state.newQuiz== null || state.newQuiz!.image == 'https://images.pexels.com/photos/301920/pexels-photo-301920.jpeg?cs=srgb&dl=pexels-pixabay-301920.jpg&fm=jpg')? Image.network(
                              height: height * 0.2,
                              width: width * 0.3,
                              'https://images.pexels.com/photos/301920/pexels-photo-301920.jpeg?cs=srgb&dl=pexels-pixabay-301920.jpg&fm=jpg',
                            fit: BoxFit.cover,): Image.file(File(state.newQuiz!.image!),
                              height: height * 0.2,
                              width: width * 0.3,
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
                            TextButton(onPressed: () async{
                              final image =
                                  await ImagePicker().pickImage(source: ImageSource.gallery);
                              if (image != null && state.newQuiz != null){
                                context.read<QuizCubit>().changeImage(image.path);
                              }
                            },
                                child: Text(
                              LocaleKeys.change_pic.tr(),
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
                    Row(
                      children: [
                        midSizedBoxWidth,
                        Text(LocaleKeys.category.tr(),
                            style: Theme.of(context).textTheme.bodySmall),
                        spacer,
                        TextButton(child: Text('+ ${LocaleKeys.add_category.tr()}',
                            style: Theme.of(context).textTheme.bodySmall), onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => AddCatDialog(title: LocaleKeys.add_category.tr(), categories: state.categories, onCategoryAdded: (String value){
                                addCategory(value, context);
                              },
                                onCategoryDeleted: (Category category){
                                  deleteCategory(category, context);
                                },
                                getCategories: () => getCategories(context),
                              ));
                        },),
                      ],
                    ),
                    midSizedBoxHeight,
                    SizedBox(
                      height: height * 0.07,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: getCategories(context).length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              BlocBuilder<QuizCubit, QuizState>(
                                builder: (context, state) {
                                  return CustomButton(
                                      text: state.categories[index].name,
                                      onPressed: () {
                                          context.read<QuizCubit>().changeCategory(state.categories[index]);
                                          for (int i = 0; i < state.categories.length; i++) {
                                            if (i != index) {
                                              state.categories[i].isSelected = false;
                                            }
                                            else{
                                              state.categories[i].isSelected = true;
                                            }
                                          }
                                      },
                                      gradient: LinearGradient(
                                        colors:
                                            state.categories[index].isSelected ? state.categories[index].darkGradient! : state.categories[index].gradient,
                                      ),
                                  );
                                }
                              ),
                              midSizedBoxWidth,
                            ],
                          );
                        },
                      ),
                    ),
                    bigSizedBoxHeight,
                    BlocBuilder<QuizCubit, QuizState>(
                      builder: (context, state) {
                        return CustomButton(
                            text: 'Go to questions', //TODO: hardcode
                            onPressed: () {
                              state.newQuiz!.questions = [OneChoiceQuestion.empty(options: [''])];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const QuestionCreate()));
                            });
                      },
                    ) ,
                    bigSizedBoxHeight,
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
