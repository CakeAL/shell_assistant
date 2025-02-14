import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shell_assistant/src/rust/api/command.dart';

class OtherFunctions extends StatefulWidget {
  const OtherFunctions({super.key});

  @override
  State<OtherFunctions> createState() => _OtherFunctionsState();
}

class _OtherFunctionsState extends State<OtherFunctions> {
  bool _openTheLaptopLid = false;
  bool _connectToThePower = false;

  Widget _row(String text1, String text2) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(text1),
        ),
        Expanded(flex: 2, child: SelectableText(text2))
      ],
    );
  }

  Widget _expandCard({
    required IconData icon,
    required String title,
    required Widget content,
    required String? path,
  }) {
    return Expander(
        header: Row(
            children: [Icon(icon, size: 20), SizedBox(width: 10), Text(title)]),
        content: content,
        // initiallyExpanded: true,
        trailing: Container(
          height: 31,
          constraints: const BoxConstraints(minWidth: 75),
          child: path == null
              ? null
              : Button(
                  child: const Row(children: [
                    Icon(FluentIcons.open_in_new_window),
                    SizedBox(width: 6.0),
                    Text('Open')
                  ]),
                  onPressed: () => openFolder(path: path),
                ),
        ));
  }

  Widget _perventAutoBootCard() {
    return _expandCard(
        icon: FluentIcons.power_button,
        title: AppLocalizations.of(context)!.preventAutoBoot,
        content: Padding(
            padding: const EdgeInsets.only(left: 30), // 左侧空出 20
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // _row(AppLocalizations.of(context)!.currentFolderSize,
              //     "${(getFolderSize(path: recordingsPath) / BigInt.from(1024 * 1024)).toStringAsFixed(2)} MiB"),
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
        path: null);
  }

  @override
  Widget build(BuildContext context) {
    final String dynamicWallpaperPath =
        "/Library/Application Support/com.apple.idleassetsd/Customer";
    final String recordingsPath =
        "/Users/${getUserName()}/Library/Group Containers/group.com.apple.VoiceMemos.shared/Recordings";

    return ScaffoldPage.scrollable(
      header:
          PageHeader(title: Text(AppLocalizations.of(context)!.otherFunctions)),
      children: [
        _expandCard(
            icon: FluentIcons.picture_center,
            title: AppLocalizations.of(context)!.openDynamicWallpapersFolder,
            content: Padding(
                padding: const EdgeInsets.only(left: 30), // 左侧空出 20
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _row(AppLocalizations.of(context)!.currentFolderSize,
                          "${(getFolderSize(path: dynamicWallpaperPath) / BigInt.from(1024 * 1024)).toStringAsFixed(2)} MiB"),
                      _row(AppLocalizations.of(context)!.folderPath,
                          dynamicWallpaperPath)
                    ])),
            path: dynamicWallpaperPath),
        SizedBox(height: 10),
        _expandCard(
            icon: FluentIcons.microphone,
            title: AppLocalizations.of(context)!.openRecordingsFolder,
            content: Padding(
                padding: const EdgeInsets.only(left: 30), // 左侧空出 20
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // _row(AppLocalizations.of(context)!.currentFolderSize,
                      //     "${(getFolderSize(path: recordingsPath) / BigInt.from(1024 * 1024)).toStringAsFixed(2)} MiB"),
                      _row(AppLocalizations.of(context)!.folderPath,
                          recordingsPath)
                    ])),
            path: recordingsPath),
        SizedBox(height: 10),
        _perventAutoBootCard(),
      ],
    );
  }
}
