import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shell_assistant/src/rust/api/read_value.dart';
import 'package:shell_assistant/widgets/expand_card.dart';

class BootOptions extends StatefulWidget {
  const BootOptions({super.key});

  @override
  State<BootOptions> createState() => _BootOptionsState();
}

class _BootOptionsState extends State<BootOptions> {
  bool _openTheLaptopLid = false;
  bool _connectToThePower = false;
  bool _playSoundOnStartup = true;

  @override
  void initState() {
    super.initState();
    final autoBootNvramValue = readNvramValue(function: 0);
    if (autoBootNvramValue != null) {
      _openTheLaptopLid = autoBootNvramValue == 0 || autoBootNvramValue == 1;
      _connectToThePower = autoBootNvramValue == 0 || autoBootNvramValue == 2;
    }
    final playSoundOnStartupValue = readNvramValue(function: 1);
    if (playSoundOnStartupValue != null) {
      _playSoundOnStartup = playSoundOnStartupValue == 0;
    }
  }

  Widget _perventAutoBootCard() {
    return ExpandCard(
        icon: FluentIcons.power_button,
        title: AppLocalizations.of(context)!.preventAutoBoot,
        content: Padding(
            padding: const EdgeInsets.only(left: 30), // 左侧空出 20
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(AppLocalizations.of(context)!.preventAutoBootRequirements),
              Text(AppLocalizations.of(context)!.preventAutoBootUsage),
              SizedBox(height: 5),
              Row(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ToggleSwitch(
                          checked: _openTheLaptopLid,
                          onChanged: (v) =>
                              setState(() => _openTheLaptopLid = v),
                          content: Text(
                              AppLocalizations.of(context)!.openTheLaptopLid),
                        ),
                        SizedBox(height: 5),
                        ToggleSwitch(
                          checked: _connectToThePower,
                          onChanged: (v) =>
                              setState(() => _connectToThePower = v),
                          content: Text(
                              AppLocalizations.of(context)!.connectToThePower),
                        ),
                      ]),
                  Spacer(),
                  FilledButton(
                    child: Text(AppLocalizations.of(context)!.submit),
                    onPressed: () => {},
                  )
                ],
              )
            ])),
        initiallyExpanded: true);
  }

  Widget _playSoundOnStartupCard() {
    return ExpandCard(
        icon: FluentIcons.speakers,
        title: AppLocalizations.of(context)!.playSoundOnStartup,
        content: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: ToggleSwitch(
            checked: _playSoundOnStartup,
            onChanged: (v) => setState(() => _playSoundOnStartup = v),
            content: Text("Duang"),
          ),
        ),
        path: null,
        initiallyExpanded: true);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header:
          PageHeader(title: Text(AppLocalizations.of(context)!.bootOptions)),
      children: [
        _perventAutoBootCard(),
        SizedBox(height: 10),
        _playSoundOnStartupCard()
      ],
    );
  }
}
