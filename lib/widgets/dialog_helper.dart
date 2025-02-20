import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogHelper {
  static void showPasswordDialog(BuildContext context,
      TextEditingController password, Function executeCommand) async {
    await showDialog<String>(
        context: context,
        builder: (context) => ContentDialog(
              title: Text(AppLocalizations.of(context)!.enterPassword),
              content: SizedBox(
                height: 30,
                child: PasswordBox(
                  controller: password,
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
                    executeCommand();
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}
