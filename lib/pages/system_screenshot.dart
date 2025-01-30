import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shell_assistant/widgets/open_to_see.dart';

class SystemScreenshot extends StatefulWidget {
  const SystemScreenshot({super.key});

  @override
  State<SystemScreenshot> createState() => _SystemScreenshotState();
}

class _SystemScreenshotState extends State<SystemScreenshot> {
  final _screenshotSavedFolder = TextEditingController(); // 0
  final _fileNamePrefix = TextEditingController(); // 1
  String _screenshotFormat = "png"; // 2
  bool _disabledScreenshotsShadow = false; // 3
  bool _fileNameWithTimestamp = true; // 4
  bool _screenshotThumbnail = true; // 5

  late final Map<int, String> _commandMap = {};
  late String _command = "";

  @override
  void initState() {
    super.initState();
    _screenshotSavedFolder.addListener(() {
      _updateCommand(
          0,
          _screenshotSavedFolder.text.isNotEmpty
              ? 'defaults write com.apple.screencapture location "${_screenshotSavedFolder.text}"'
              : '');
    });

    _fileNamePrefix.addListener(() {
      _updateCommand(
          1,
          _fileNamePrefix.text.isNotEmpty
              ? 'defaults write com.apple.screencapture name "${_fileNamePrefix.text}"'
              : '');
    });
  }

  void _updateCommand(int key, String value) {
    setState(() {
      if (value.isNotEmpty) {
        _commandMap[key] = value;
      } else {
        _commandMap.remove(key);
      }
      _command = "${_commandMap.values.join(" && \\\n")} && \\\nkillall SystemUIServer";
    });
  }

  @override
  void dispose() {
    _screenshotSavedFolder.dispose();
    _fileNamePrefix.dispose();
    super.dispose();
  }

  Future<void> _pickDir() async {
    String result = await FilePicker.platform.getDirectoryPath() ?? "";
    // 去除不需要的前缀部分，假设路径以 '/Volumes/Macintosh HD' 开头
    if (result.startsWith('/Volumes/Macintosh HD')) {
      result = result.replaceFirst('/Volumes/Macintosh HD', '');
    }
    _screenshotSavedFolder.text = result;
  }

  Widget _firstCard() {
    return Card(
        child: Row(
      children: [
        Expanded(
            flex: 3,
            child: InfoLabel(
                label: AppLocalizations.of(context)!.screenshotSavedLocation,
                child: TextBox(
                  placeholder: "~/Desktop",
                  expands: false,
                  controller: _screenshotSavedFolder,
                  readOnly: true,
                  onTap: () => _pickDir(),
                ))),
        SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 2,
            child: InfoLabel(
                label: AppLocalizations.of(context)!.fileNamePrefix,
                child: TextBox(
                  placeholder: "Such as: Shot_",
                  expands: false,
                  controller: _fileNamePrefix,
                ))),
      ],
    ));
  }

  Widget _secondCard() {
    List<String> formats = ['png', 'jpg', 'bmp', 'gif', 'pdf', 'tiff'];
    return Card(
      child: InfoLabel(
        label: AppLocalizations.of(context)!.screenshotFormat,
        child: Row(
          children: [
            ...formats.map((format) {
              return Expanded(
                  child: FilledButton(
                onPressed: _screenshotFormat == format
                    ? null
                    : () {
                        setState(() {
                          _screenshotFormat = format;
                        });
                        _updateCommand(2,
                            'defaults write com.apple.screencapture type $_screenshotFormat');
                      },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.resolveWith<Color>((states) {
                    return states.contains(WidgetState.disabled)
                        ? FluentTheme.of(context).accentColor.dark
                        : Colors.grey[60];
                  }),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
                child: Text(format),
              ));
            })
          ],
        ),
      ),
    );
  }

  Widget _thirdCard() {
    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        ToggleSwitch(
          checked: _disabledScreenshotsShadow,
          onChanged: (v) {
            setState(() => _disabledScreenshotsShadow = v);
            _updateCommand(3,
                'defaults write com.apple.screencapture disable-shadow -bool $_disabledScreenshotsShadow');
          },
          content:
              Text(AppLocalizations.of(context)!.disabledScreenshotsShadow),
        ),
        ToggleSwitch(
          checked: _fileNameWithTimestamp,
          onChanged: (v) {
            setState(() => _fileNameWithTimestamp = v);
            _updateCommand(4,
                'defaults write com.apple.screencapture include-date -bool $_fileNameWithTimestamp');
          },
          content: Text(AppLocalizations.of(context)!.fileNameWithTimestamp),
        ),
        ToggleSwitch(
          checked: _screenshotThumbnail,
          onChanged: (v) {
            setState(() => _screenshotThumbnail = v);
            _updateCommand(5,
                'defaults write com.apple.screencapture show-thumbnail -bool $_screenshotThumbnail');
          },
          content: Text(AppLocalizations.of(context)!.screenshotThumbnail),
        ),
      ],
    ));
  }

  Widget _forthCard() {
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
        onPressed: () => debugPrint('pressed button'),
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
          onPressed: () => debugPrint('pressed button'),
        ),
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(AppLocalizations.of(context)!.systemScreenshot),
      ),
      children: [
        _firstCard(),
        SizedBox(height: 10),
        _secondCard(),
        SizedBox(height: 10),
        _thirdCard(),
        SizedBox(height: 10),
        _forthCard(),
        SizedBox(height: 10),
        OpenToSee(command: _command)
      ],
    );
  }
}
