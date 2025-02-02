import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingCard extends StatelessWidget {
  final Function writeSettings;
  final Function resetToDefault;

  const SettingCard(
      {super.key, required this.writeSettings, required this.resetToDefault});

  @override
  Widget build(BuildContext context) {
    return Card(
        // backgroundColor: Colors.transparent,
        // borderColor: Colors.transparent,
        child: Row(children: [
      Expanded(
          child: FilledButton(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Icon(FluentIcons.settings_add, size: 15),
          Text(AppLocalizations.of(context)!.writeSettings,
              style: TextStyle(fontSize: 15))
        ]),
        onPressed: () => writeSettings(),
      )),
      SizedBox(width: 40),
      Expanded(
        child: Button(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Icon(
              FluentIcons.default_settings,
              size: 15,
            ),
            Text(AppLocalizations.of(context)!.resetToDefault,
                style: TextStyle(fontSize: 15))
          ]),
          onPressed: () => resetToDefault(),
        ),
      )
    ]));
  }
}
