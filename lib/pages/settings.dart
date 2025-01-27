import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shell_assistant/theme.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, child) {
        return ScaffoldPage.scrollable(
          header: PageHeader(
            title: Text(AppLocalizations.of(context)!.settings),
          ),
          children: [
            Text(AppLocalizations.of(context)!.theme,
                style: FluentTheme.of(context).typography.bodyLarge),
            SizedBox(height: 10),
            Row(spacing: 20.0, children: [
              RadioButton(
                checked: appTheme.mode == ThemeMode.system,
                onChanged: (change) {
                  appTheme.mode = ThemeMode.system;
                },
                content: Text(AppLocalizations.of(context)!.system),
              ),
              RadioButton(
                checked: appTheme.mode == ThemeMode.light,
                onChanged: (change) {
                  appTheme.mode = ThemeMode.light;
                },
                content: Text(AppLocalizations.of(context)!.light),
              ),
              RadioButton(
                checked: appTheme.mode == ThemeMode.dark,
                onChanged: (change) {
                  appTheme.mode = ThemeMode.dark;
                },
                content: Text(AppLocalizations.of(context)!.dark),
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            Text(AppLocalizations.of(context)!.language,
                style: FluentTheme.of(context).typography.bodyLarge),
            SizedBox(height: 10),
            Row(spacing: 20.0, children: [
              RadioButton(
                checked: appTheme.locale.languageCode == "zh",
                onChanged: (change) {
                  appTheme.locale = Locale("zh");
                },
                content: Text("汉语"),
              ),
              RadioButton(
                checked: appTheme.locale.languageCode == "en",
                onChanged: (change) {
                  appTheme.locale = Locale("en");
                },
                content: Text("English"),
              )
            ])
          ],
        );
      },
    );
  }
}
