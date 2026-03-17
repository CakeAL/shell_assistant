import 'package:fluent_ui/fluent_ui.dart';
import 'package:shell_assistant/l10n/app_localizations.dart';
import 'package:shell_assistant/src/rust/api/command.dart';
import 'package:shell_assistant/widgets/expand_card.dart';

const List<(int, String)> accentColorNumber = [
  (-2, "#007AFF"),
  (4, "#007AFF"),
  (5, "#953D96"),
  (6, "#F74F9E"),
  (0, "#E0383E"),
  (1, "#F7821B"),
  (2, "#FFC726"),
  (3, "#62BA46"),
  (-1, "#989898"),
];

const List<(int, String)> hardwareEnclosureNumber = [
  // iMac 2021
  (3, "#E3A024"),
  (4, "#2E676B"),
  (5, "#3D637D"),
  (6, "#CC3338"),
  (7, "#484D7C"),
  (8, "#BD542D"),
  // iMac 2024 不生效🤔
  (9, "#E3A024"),
  (10, "#2E676B"),
  (11, "#3D637D"),
  (12, "#CC3338"),
  (13, "#484D7C"),
  (14, "#BD542D"),
  // Macbook Neo 2026
  (15, "#98A8D9"),
  (16, "#B5D65A"),
  (17, "#FF7F99"),
];

class OtherFunctions extends StatefulWidget {
  const OtherFunctions({super.key});

  @override
  State<OtherFunctions> createState() => _OtherFunctionsState();
}

class _OtherFunctionsState extends State<OtherFunctions> {
  Widget _accentColorCard() {
    final sections = [
      ("System", accentColorNumber, false),
      ("iMac 2021", hardwareEnclosureNumber.sublist(0, 6), true),
      ("iMac 2024", hardwareEnclosureNumber.sublist(6, 12), true),
      ("Macbook Neo 2026", hardwareEnclosureNumber.sublist(12, 15), true),
    ];

    return ExpandCard(
      icon: FluentIcons.color,
      title: AppLocalizations.of(context)!.accentColor,
      initiallyExpanded: true,
      content: Column(
        spacing: 20,
        children: sections.map((section) {
          final label = section.$1;
          final colors = section.$2;
          final isHardwareEnclosureNumber = section.$3;
          return Row(
            spacing: 20,
            children: colors.map((color) {
              return Tooltip(
                message: label,
                child: _buildColorBlock(color, isHardwareEnclosureNumber),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildColorBlock(
    final (int, String) color,
    final bool isHardwareEnclosureNumber,
  ) {
    String rgbHex = color.$2.substring(1);
    Color colorObj = Color(int.parse('FF$rgbHex', radix: 16));

    // Helper function to adjust brightness
    Color adjustBrightness(Color baseColor, double factor) {
      final hslColor = HSLColor.fromColor(baseColor);
      final adjustedColor = hslColor.withLightness(
        (hslColor.lightness * factor).clamp(0.0, 1.0),
      );
      return adjustedColor.toColor();
    }

    return Padding(
      padding: const EdgeInsetsDirectional.all(2),
      child: Button(
        onPressed: () async {
          executeChangeAccentColor(
            colorNumber: color.$1,
            isHardwareEnclosureNumber: isHardwareEnclosureNumber,
          );

          await displayInfoBar(
            context,
            builder: (context, close) {
              return InfoBar(
                title: const Text('Info'),
                content: Text(AppLocalizations.of(context)!.accentColorInfo),
                action: IconButton(
                  icon: const WindowsIcon(WindowsIcons.clear),
                  onPressed: close,
                ),
                severity: InfoBarSeverity.info,
              );
            },
          );
        },
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(EdgeInsetsDirectional.zero),
          backgroundColor: WidgetStateProperty.resolveWith((final states) {
            if (states.isPressed) {
              return adjustBrightness(
                colorObj,
                0.8,
              ); // Slightly darker when pressed
            } else if (states.isHovered) {
              return adjustBrightness(
                colorObj,
                1.2,
              ); // Slightly lighter when hovered
            }
            return colorObj;
          }),
        ),
        child: Container(
          height: 40,
          width: 40,
          alignment: AlignmentDirectional.center,
        ),
      ),
    );
  }

  Widget _row(String text1, String text2) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(text1)),
        Expanded(flex: 2, child: SelectableText(text2)),
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
      header: PageHeader(
        title: Text(AppLocalizations.of(context)!.otherFunctions),
      ),
      children: [
        ExpandCard(
          icon: FluentIcons.picture_center,
          title: AppLocalizations.of(context)!.openWallpapersFolder,
          content: Padding(
            padding: const EdgeInsets.only(left: 30), // 左侧空出 20
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _row(
                  AppLocalizations.of(context)!.currentFolderSize,
                  "${(getFolderSize(path: wallpaperPath) / BigInt.from(1024 * 1024)).toStringAsFixed(2)} MiB",
                ),
                _row(AppLocalizations.of(context)!.folderPath, wallpaperPath),
              ],
            ),
          ),
          path: wallpaperPath,
        ),
        SizedBox(height: 10),
        ExpandCard(
          icon: FluentIcons.picture_center,
          title: AppLocalizations.of(context)!.openDynamicWallpapersFolder,
          content: Padding(
            padding: const EdgeInsets.only(left: 30), // 左侧空出 20
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _row(
                  AppLocalizations.of(context)!.currentFolderSize,
                  "${(getFolderSize(path: dynamicWallpaperPath) / BigInt.from(1024 * 1024)).toStringAsFixed(2)} MiB",
                ),
                _row(
                  AppLocalizations.of(context)!.folderPath,
                  dynamicWallpaperPath,
                ),
              ],
            ),
          ),
          path: dynamicWallpaperPath,
        ),
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
                _row(AppLocalizations.of(context)!.folderPath, recordingsPath),
              ],
            ),
          ),
          path: recordingsPath,
        ),
        SizedBox(height: 10),
        _accentColorCard(),
      ],
    );
  }
}
