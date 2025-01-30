import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shell_assistant/src/rust/api/command.dart';
import 'package:shell_assistant/widgets/app_drop_region.dart';
import 'package:shell_assistant/widgets/file_picker_box.dart';
import 'package:shell_assistant/widgets/open_to_see.dart';

class BypassSignature extends StatefulWidget {
  const BypassSignature({super.key});

  @override
  State<BypassSignature> createState() => _BypassSignatureState();
}

class _BypassSignatureState extends State<BypassSignature> {
  final _controller = TextEditingController();
  final _password = TextEditingController();
  late String _command = "sudo xattr -d com.apple.quarantine ";

  @override
  void initState() {
    super.initState();
    // 监听 _controller
    _controller.addListener(() {
      setState(() {
        _command = "sudo xattr -d com.apple.quarantine '${_controller.text}'";
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showPasswordDialog(BuildContext context) async {
    if (_controller.text.isEmpty) {
      return;
    }
    await showDialog<String>(
        context: context,
        builder: (context) => ContentDialog(
              title: Text(AppLocalizations.of(context)!.enterPassword),
              content: SizedBox(
                height: 30,
                child: PasswordBox(
                  controller: _password,
                ),
              ),
              actions: [
                Button(
                  child: Text(AppLocalizations.of(context)!.cancel),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FilledButton(
                  child: Text(AppLocalizations.of(context)!.submit),
                  onPressed: () {
                    _executeCommand();
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  Future<void> _executeCommand() async {
    InfoBarSeverity severity = InfoBarSeverity.error;
    // debugPrint(_controller.text);
    String text = executeBypassSignature(
        path: _controller.text, password: _password.text);
    _password.text = "";
    debugPrint(text);
    if (text == "Success" ||
        text.contains("No such xattr: com.apple.quarantine")) {
      text = "Success";
      severity = InfoBarSeverity.success;
    }
    // debugPrint(text);
    await displayInfoBar(context, builder: (context, close) {
      return InfoBar(
        title: Text(text),
        action: IconButton(
          icon: const Icon(FluentIcons.clear),
          onPressed: close,
        ),
        severity: severity,
      );
    });
  }

  Widget _firstCard() {
    return Card(
        child: Column(
      children: [
        AppDropRegion(
          controller: _controller,
        ),
        Row(
          children: [
            FilePickerBox(controller: _controller),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: FilledButton(
              child: Text(AppLocalizations.of(context)!.submit),
              onPressed: () => _showPasswordDialog(context),
            ))
          ],
        )
      ],
    ));
  }

  Widget _secondCard() {
    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.bypassFunction,
            style: TextStyle(height: 1.5)),
        Text(
          AppLocalizations.of(context)!.bypassUsage,
          style: TextStyle(height: 1.5),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
          title: Text(AppLocalizations.of(context)!.bypassSignature)),
      children: [
        _firstCard(),
        SizedBox(height: 10),
        _secondCard(),
        SizedBox(height: 10),
        OpenToSee(command: _command),
      ],
    );
  }
}
