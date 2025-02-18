import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shell_assistant/src/rust/api/command.dart';
import 'package:shell_assistant/widgets/expand_card.dart';

class OtherFunctions extends StatefulWidget {
  const OtherFunctions({super.key});

  @override
  State<OtherFunctions> createState() => _OtherFunctionsState();
}

class _OtherFunctionsState extends State<OtherFunctions> {
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

  @override
  Widget build(BuildContext context) {
    final String wallpaperPath = "/System/Library/Desktop Pictures";
    final String dynamicWallpaperPath =
        "/Library/Application Support/com.apple.idleassetsd/Customer";
    final String recordingsPath =
        "/Users/${getUserName()}/Library/Group Containers/group.com.apple.VoiceMemos.shared/Recordings";

    return ScaffoldPage.scrollable(
      header:
          PageHeader(title: Text(AppLocalizations.of(context)!.otherFunctions)),
      children: [
        ExpandCard(
            icon: FluentIcons.picture_center,
            title: AppLocalizations.of(context)!.openWallpapersFolder,
            content: Padding(
                padding: const EdgeInsets.only(left: 30), // 左侧空出 20
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _row(AppLocalizations.of(context)!.currentFolderSize,
                          "${(getFolderSize(path: wallpaperPath) / BigInt.from(1024 * 1024)).toStringAsFixed(2)} MiB"),
                      _row(AppLocalizations.of(context)!.folderPath,
                          wallpaperPath)
                    ])),
            path: wallpaperPath),
        SizedBox(height: 10),
        ExpandCard(
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
        ExpandCard(
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
      ],
    );
  }
}
