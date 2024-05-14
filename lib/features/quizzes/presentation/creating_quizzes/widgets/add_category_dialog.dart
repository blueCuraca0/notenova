import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/widgets/custom_button.dart';
import 'package:notenova/features/quizzes/domain/entities/category.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'add_cat_dialog2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/features/quizzes/presentation/state_management/quiz_cubit.dart';

class AddCatDialog extends StatefulWidget {
  final String title;
  List<Category> categories;
  final Function(String) onCategoryAdded;
  final Function(Category) onCategoryDeleted;
  final Function getCategories;


  AddCatDialog({super.key, required this.title, required this.categories, required this.onCategoryAdded, required this.onCategoryDeleted, required this.getCategories});

  @override
  State<AddCatDialog> createState() => _AddCatDialogState();
}

class _AddCatDialogState extends State<AddCatDialog> {
  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).cardColor;

    return AlertDialog(
          title: Text(widget.title),
          titleTextStyle: Theme.of(context).textTheme.bodyLarge,
          contentTextStyle: Theme.of(context).textTheme.bodyMedium,
          alignment: Alignment.center,
          backgroundColor: color,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.white,
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions:[
            Column(
              children: List<Widget>.generate(widget.categories.length, (index) => DialogButton(category: widget.categories[index], onCategoryDeleted: (value){
                widget.onCategoryDeleted(value);
                setState(() {
                  widget.categories.length > 0 ? widget.categories.removeAt(index) : widget.categories = [];
                });
              })),
            ),
            Row(
              children: [
                TextButton(onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => AddCatDialog2(title: LocaleKeys.add_category.tr(), onCategoryAdded: (value){
                      widget.onCategoryAdded(value);
                    },
                      ),
                  );
                  Navigator.pop(context);
                  },
                    child: Text('+ ${LocaleKeys.add_category.tr()}',
                    style: Theme.of(context).textTheme.bodySmall)),
                spacer,
              ],
            )
          ],
        );
  }
}

class DialogButton extends StatelessWidget {
  final Category category;
  final Function(Category) onCategoryDeleted;

  const DialogButton({required this.category, super.key, required this.onCategoryDeleted});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            children: [
              CustomButton(text: category.name, onPressed: (){}, gradient: LinearGradient(colors: category.gradient),),
              spacer,
              IconButton(
                onPressed: () {
                  onCategoryDeleted(category);
                },
                icon: const Icon(Icons.delete_outline),
              )
            ],
          ),
        ),
        smallSizedBoxHeight,
      ],
    );
  }
}