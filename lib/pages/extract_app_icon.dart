import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shell_assistant/widgets/app_drop_region.dart';
import 'package:shell_assistant/widgets/file_picker_box.dart';

class ExtractAppIcon extends StatefulWidget {
  const ExtractAppIcon({super.key});

  @override
  State<ExtractAppIcon> createState() => _ExtractAppIconState();
}

class _ExtractAppIconState extends State<ExtractAppIcon> {
  final _controller = TextEditingController();

  Widget _firstCard() {
    return Card(
      child: Column(
        children: [
          AppDropRegion(controller: _controller),
          Row(
            children: [FilePickerBox(controller: _controller)],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(AppLocalizations.of(context)!.extractAppIcon),
      ),
      children: [
        _firstCard(),
        SizedBox(height: 10),
        Card(
            child:
                Text(AppLocalizations.of(context)!.extractAppIconDescription)),
      ],
    );
  }
}
