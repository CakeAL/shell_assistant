import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SystemScreenshot extends StatefulWidget {
  const SystemScreenshot({super.key});

  @override
  State<SystemScreenshot> createState() => _SystemScreenshotState();
}

class _SystemScreenshotState extends State<SystemScreenshot> {
  final _screenshotSavedFolder = TextEditingController();
  final _fileNamePrefix = TextEditingController();
  String _screenshotFormat = "png";

  Widget _firstCard() {
    return Card(
        child: Row(
      children: [
        Expanded(
            flex: 3,
            child: InfoLabel(
                label: AppLocalizations.of(context)!.screenshotSavedLocation,
                child: TextBox(
                  placeholder: "~/Downloads",
                  expands: false,
                  controller: _screenshotSavedFolder,
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
                    : () => setState(() {
                          _screenshotFormat = format;
                        }),
                style: ButtonStyle(backgroundColor:
                    WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return FluentTheme.of(context).accentColor.dark;
                  } else {
                    return Colors.grey[60];
                  }
                })),
                child: Text(format),
              ));
            })
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(AppLocalizations.of(context)!.systemScreenshot),
      ),
      children: [
        _firstCard(),
        SizedBox(
          height: 10,
        ),
        _secondCard()
      ],
    );
  }
}
