import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shell_assistant/src/rust/api/command.dart';
import 'package:shell_assistant/widgets/app_drop_region.dart';
import 'package:shell_assistant/widgets/dialog_helper.dart';
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

  Future<void> _executeCommand() async {
    InfoBarSeverity severity = InfoBarSeverity.error;
    // debugPrint(_controller.text);
    String text;
    try {
      text = executeBypassSignature(
          path: _controller.text, password: _password.text);
    } catch (e) {
      text = e.toString();
    }
    // _password.text = "";
    debugPrint(text);
    if (text == "Success" ||
        text.contains("No such xattr: com.apple.quarantine")) {
      text = "Success";
      severity = InfoBarSeverity.success;
    }
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
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  DialogHelper.showPasswordDialog(
                      context, _password, _executeCommand);
                }
              },
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
