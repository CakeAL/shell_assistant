import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shell_assistant/widgets/open_to_see.dart';
import 'package:shell_assistant/widgets/setting_card.dart';

class Dock extends StatefulWidget {
  const Dock({super.key});

  @override
  State<Dock> createState() => _DockState();
}

class _DockState extends State<Dock> {
  final List<bool> _switchStates = [false, false, false, false, false];
  final List<TextEditingController> times = [
    TextEditingController(),
    TextEditingController()
  ];
  final List<FlyoutController> _flyoutController = [
    FlyoutController(),
    FlyoutController(),
    FlyoutController(),
    FlyoutController(),
    FlyoutController(),
    FlyoutController(),
    FlyoutController()
  ];

  Widget _flyTarget(int index, String desc) {
    return FlyoutTarget(
        controller: _flyoutController[index],
        child: MouseRegion(
          onEnter: (event) {
            _flyoutController[index].showFlyout(
              autoModeConfiguration: FlyoutAutoConfiguration(
                preferredMode: FlyoutPlacementMode.topCenter,
              ),
              barrierDismissible: true,
              dismissOnPointerMoveAway: true,
              dismissWithEsc: true,
              // navigatorKey: rootNavigatorKey.currentState,
              builder: (context) {
                return FlyoutContent(child: Text(desc));
              },
            );
          },
          child: IconButton(
            icon: const Icon(
              FluentIcons.status_circle_question_mark,
              size: 20,
            ),
            onPressed: () {},
          ),
        ));
  }

  Widget _firstCard(List<String> labels, List<String> descriptions) {
    return Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: List.generate(7, (index) {
              if (index >= 5) {
                return Row(
                  children: [
                    Text(labels[index]),
                    SizedBox(width: 5),
                    SizedBox(
                        width: 50,
                        child: TextBox(
                          controller: times[index-5],
                          placeholder: "500",
                        )),
                    SizedBox(width: 5),
                    Text("ms"),
                    _flyTarget(index, descriptions[index])
                  ],
                );
              }
              return ToggleSwitch(
                checked: _switchStates[index],
                onChanged: (v) {
                  setState(() {
                    _switchStates[index] = v;
                  });
                },
                content: Row(children: [
                  Text(labels[index]),
                  _flyTarget(index, descriptions[index])
                ]),
              );
            })));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations local = AppLocalizations.of(context)!;

    final List<String> labels = [
      local.openStackByScroll,
      local.highlightIconHoverOver,
      local.enableSingleAppMode,
      local.disableAdjustDockSize,
      local.useSuckEffect,
      local.animationTime,
      local.autohideDelay
    ];

    final List<String> descriptions = [
      local.openStackByScrollDescription,
      local.highlightIconHoverOverDescription,
      local.enableSingleAppModeDescription,
      local.disableAdjustDockSizeDescription,
      local.useSuckEffectDescription,
      local.animationTimeDescription,
      local.autohideDelayDescription
    ];

    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text(AppLocalizations.of(context)!.dock)),
      children: [
        _firstCard(labels, descriptions),
        SizedBox(height: 10),
        SettingCard(writeSettings: () {}, resetToDefault: () {}),
        SizedBox(height: 10),
        OpenToSee(command: "Hello world!"),
      ],
    );
  }
}
