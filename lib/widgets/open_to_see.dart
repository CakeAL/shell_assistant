import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OpenToSee extends StatefulWidget {
  final String command;
  const OpenToSee({super.key, required this.command});

  @override
  State<OpenToSee> createState() => _OpenToSeeState();
}

class _OpenToSeeState extends State<OpenToSee> {
  bool isOpen = false;
  bool isCopying = false;

  @override
  Widget build(BuildContext context) {
    return Expander(
      header: Text(AppLocalizations.of(context)!.openToSee),
      content: SelectableText(widget.command),
      onStateChanged: (state) {
        // this is done because [onStateChanges] is called while the [Expander]
        // is updating. By using this, we schedule the rebuilt of this widget
        // to the next frame
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (mounted) setState(() => isOpen = state);
        });
      },
      trailing: isOpen
          ? Container(
              height: 31,
              constraints: const BoxConstraints(minWidth: 75),
              child: Button(
                style: ButtonStyle(
                  backgroundColor: isCopying
                      ? WidgetStatePropertyAll(
                          FluentTheme.of(context).accentColor.defaultBrushFor(
                              FluentTheme.of(context).brightness),
                        )
                      : null,
                ),
                child: isCopying
                    ? Icon(
                        FluentIcons.check_mark,
                        color: FluentTheme.of(context)
                            .resources
                            .textOnAccentFillColorPrimary,
                        size: 18,
                      )
                    : const Row(children: [
                        Icon(FluentIcons.copy),
                        SizedBox(width: 6.0),
                        Text('Copy')
                      ]),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: widget.command));
                  setState(() => isCopying = true);
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    isCopying = false;
                    if (mounted) setState(() {});
                  });
                },
              ),
            )
          : null,
    );
  }
}
