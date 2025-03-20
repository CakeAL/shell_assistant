import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shell_assistant/src/rust/api/command.dart';
import 'package:shell_assistant/src/rust/api/entity.dart';
import 'package:shell_assistant/widgets/app_drop_region.dart';
import 'package:shell_assistant/widgets/file_picker_box.dart';

class GetAppArch extends StatefulWidget {
  const GetAppArch({super.key});

  @override
  State<GetAppArch> createState() => _GetAppArchState();
}

class _GetAppArchState extends State<GetAppArch> {
  final _controller = TextEditingController();
  Set<Architecture> archs = {};

  void _execution() async {
    if (_controller.text.isEmpty) return;
    setState(() {
      archs = getAppArch(path: _controller.text);
    });
  }

  Widget _firstCard() {
    return Card(
      child: Column(
        children: [
          AppDropRegion(controller: _controller),
          Row(
            children: [
              FilePickerBox(controller: _controller),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: FilledButton(
                child: Text(AppLocalizations.of(context)!.submit),
                onPressed: () => _execution(),
              ))
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(AppLocalizations.of(context)!.getAppArch),
      ),
      children: [
        _firstCard(),
        SizedBox(height: 10),
        Card(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(AppLocalizations.of(context)!.appArchs),
              ...archs.map((arch) {
                if (arch == Architecture.x8664) {
                  return Text(' x86_64');
                } else if (arch == Architecture.arm64) {
                  return Text(' arm64');
                } else if (arch == Architecture.powerPc) {
                  return Text(' PowerPC');
                }
                return SizedBox.shrink(); // Default return statement
              }),
            ],
          ),
          if (archs.containsAll({Architecture.arm64, Architecture.x8664}))
            Text(AppLocalizations.of(context)!.universal),
          if (archs.contains(Architecture.arm64) &&
              !archs.contains(Architecture.x8664))
            Text(AppLocalizations.of(context)!.onlyArm),
          if (archs.contains(Architecture.x8664) &&
              !archs.contains(Architecture.arm64))
            Text(AppLocalizations.of(context)!.onlyIntel),
          if (archs.contains(Architecture.powerPc))
            Text(AppLocalizations.of(context)!.onlyPowerPC),
        ])),
      ],
    );
  }
}
