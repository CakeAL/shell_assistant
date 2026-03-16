import 'package:fluent_ui/fluent_ui.dart';
import 'package:shell_assistant/l10n/app_localizations.dart';
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
          Icon(
            appTheme.mode == ThemeMode.dark
                ? FluentIcons.clear_night
                : FluentIcons.brightness,
          ),
          Text(
            AppLocalizations.of(context)!.theme,
            style: FluentTheme.of(context).typography.bodyLarge,
          ),
          Spacer(),
          RadioGroup<int>(
            groupValue: appTheme.mode.index,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  appTheme.mode = ThemeMode.values[value];
                });
              }
            },
            child: Row(
              spacing: 10.0,
              children: [
                RadioButton<int>(
                  value: ThemeMode.system.index,
                  content: Text(AppLocalizations.of(context)!.system),
                ),
                RadioButton<int>(
                  value: ThemeMode.light.index,
                  content: Text(AppLocalizations.of(context)!.light),
                ),
                RadioButton<int>(
                  value: ThemeMode.dark.index,
                  content: Text(AppLocalizations.of(context)!.dark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _languageCard(AppTheme appTheme) {
    return Card(
      child: Row(
        spacing: 20,
        children: [
          Icon(FluentIcons.locale_language),
          Text(
            AppLocalizations.of(context)!.language,
            style: FluentTheme.of(context).typography.bodyLarge,
          ),
          Spacer(),
          RadioGroup<int>(
            groupValue: appTheme.locale.languageCode == "zh" ? 0 : 1,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  appTheme.locale = value == 0 ? Locale("zh") : Locale("en");
                });
              }
            },
            child: Row(
              spacing: 10.0,
              children: [
                RadioButton<int>(value: 0, content: Text("汉语")),
                RadioButton<int>(value: 1, content: Text("English")),
              ],
            ),
          ),
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
