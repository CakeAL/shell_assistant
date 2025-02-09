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
  Widget _themeCard(AppTheme appTheme) {
    return Card(
        child: Row(
      spacing: 20,
      children: [
        Icon(appTheme.mode == ThemeMode.dark
            ? FluentIcons.clear_night
            : FluentIcons.brightness),
        Text(AppLocalizations.of(context)!.theme,
            style: FluentTheme.of(context).typography.bodyLarge),
        Spacer(),
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
      ],
    ));
  }

  Widget _languageCard(AppTheme appTheme) {
    return Card(
      child: Row(
        spacing: 20,
        children: [
          Icon(FluentIcons.locale_language),
          Text(AppLocalizations.of(context)!.language,
              style: FluentTheme.of(context).typography.bodyLarge),
          Spacer(),
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, child) {
        return ScaffoldPage.scrollable(
          header: PageHeader(
            title: Text(AppLocalizations.of(context)!.settings),
          ),
          children: [
            _themeCard(appTheme),
            SizedBox(height: 10),
            _languageCard(appTheme),
          ],
        );
      },
    );
  }
}
