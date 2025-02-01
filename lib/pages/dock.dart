import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Dock extends StatefulWidget {
  const Dock({super.key});

  @override
  State<Dock> createState() => _DockState();
}

class _DockState extends State<Dock> {
  final List<bool> _switchStates = [false, false, false, false, false];

  Widget _firstCard() {
    return Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: List.generate(5, (index) {
              return ToggleSwitch(
                  checked: _switchStates[index],
                  onChanged: (v) {
                    setState(() {
                      _switchStates[index] = v;
                    });
                  });
            })));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text(AppLocalizations.of(context)!.dock)),
      children: [
        _firstCard(),
      ],
    );
  }
}
