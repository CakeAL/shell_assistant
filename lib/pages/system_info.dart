import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SystemInfo extends StatelessWidget{
  const SystemInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text(AppLocalizations.of(context)!.systemInfo)),
      children: [
        
      ],
    );
  }
}