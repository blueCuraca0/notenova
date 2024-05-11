import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notenova/core/style/c_colors.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';

class SettingsFieldsWidget extends StatefulWidget {
  const SettingsFieldsWidget({super.key});

  @override
  State<SettingsFieldsWidget> createState() => _SettingsFieldsWidgetState();
}

class _SettingsFieldsWidgetState extends State<SettingsFieldsWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  String selectedLanguage = LocaleKeys.english.tr();
  bool isDarktheme = false;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          curve: Curves.easeOut,
          parent: _controller,
        )),
        child: Container(
          constraints: const BoxConstraints(minHeight: 900),
          decoration: const BoxDecoration(
            color: CColors.accentSoft,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 400,
              child: Padding(
                padding: mediumPadding,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(LocaleKeys.lan.tr(),
                            style: Theme.of(context).textTheme.bodyMedium),
                        spacer,
                        TextButton(
                          onPressed: () {
                            _showLanguageDialog(context);
                          },
                          child: Text(
                              context.locale.languageCode == 'en'
                                  ? LocaleKeys.english.tr()
                                  : LocaleKeys.ukrainian.tr(),
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ],
                    ),
                    smallSizedBoxHeight,
                    Row(
                      children: [
                        Text(LocaleKeys.dark_theme.tr(),
                            style: Theme.of(context).textTheme.bodyMedium),
                        spacer,
                        Switch(
                            inactiveTrackColor: Theme.of(context).primaryColor,
                            activeTrackColor: Theme.of(context).cardColor,
                            inactiveThumbColor:
                                Theme.of(context).primaryColorLight,
                            activeColor: Theme.of(context).primaryColorDark,
                            value: isDarktheme,
                            onChanged: (value) {}),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<String?> _showLanguageDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Language',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () async {
                  context.setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
                child: Text(
                  LocaleKeys.english.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TextButton(
                onPressed: () async {
                  context.setLocale(const Locale('uk'));
                  Navigator.pop(context);
                },
                child: Text(
                  LocaleKeys.ukrainian.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}