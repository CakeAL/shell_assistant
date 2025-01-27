import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shell_assistant/widgets/app_drop_region.dart';
import 'package:shell_assistant/widgets/open_to_see.dart';

class BypassSignature extends StatefulWidget {
  const BypassSignature({super.key});

  @override
  State<BypassSignature> createState() => _BypassSignatureState();
}

class _BypassSignatureState extends State<BypassSignature> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _firstCard() {
    return Card(
        child: Column(
      children: [
        Center(
          heightFactor: 1.5,
          child: AppDropRegion(
            controller: _controller,
          ),
        ),
        Row(
          children: [
            Expanded(
                flex: 3,
                child: TextBox(
                  placeholder: '/Applications/App Store.app',
                  controller: _controller,
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: FilledButton(
              child: Text(AppLocalizations.of(context)!.submit),
              onPressed: () => debugPrint('pressed button'),
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
    return ScaffoldPage.withPadding(
        header: PageHeader(
            title: Text(AppLocalizations.of(context)!.bypassSignature)),
        content: ListView(
          children: [
            _firstCard(),
            SizedBox(height: 20),
            _secondCard(),
            SizedBox(height: 20),
            OpenToSee(command: "Here should be the command"),
          ],
        ));
  }
}
