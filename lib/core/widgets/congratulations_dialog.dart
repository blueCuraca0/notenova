import 'package:flutter/material.dart';
import 'package:notenova/core/utils/constants.dart';

class CongratulationsDialog extends StatelessWidget {
  late final String _title;
  late final String _content;
  late final String _actionText;
  late final void Function(BuildContext context) _goBack;

  CongratulationsDialog({
    required String title,
    required String content,
    required String actionText,
    required void Function(BuildContext context) goBack,
    super.key}) {

    _title = title;
    _content = content;
    _actionText = actionText;
    _goBack = goBack;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text(_title),
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        content: Text(_content),
        contentTextStyle: Theme.of(context).textTheme.bodyMedium,
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: Theme.of(context).cardColor,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.white,
        elevation: 30,
        actions: [
          OutlinedButton(
            onPressed: () {
              _goBack(context);
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColorDark,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              )
            ),
            child: Text(
              _actionText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
