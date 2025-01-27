import 'package:fluent_ui/fluent_ui.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppDropRegion extends StatefulWidget {
  final TextEditingController controller;
  const AppDropRegion({super.key, required this.controller});

  @override
  State<AppDropRegion> createState() => _AppDropRegionState();
}

class _AppDropRegionState extends State<AppDropRegion> {
  Color iconColor = Color.fromARGB(50, 0, 0, 0);

  @override
  Widget build(BuildContext context) {
    return DropRegion(
      // Formats this region can accept.
      formats: Formats.standardFormats,
      hitTestBehavior: HitTestBehavior.opaque,
      onDropOver: (event) {
        // You can inspect local data here, as well as formats of each item.
        // However on certain platforms (mobile / web) the actual data is
        // only available when the drop is accepted (onPerformDrop).
        final item = event.session.items.first;
        // This drop region only supports copy operation.
        if (event.session.allowedOperations.contains(DropOperation.copy) &&
            item.platformFormats.contains("com.apple.finder.node")) {
          return DropOperation.copy;
        } else {
          return DropOperation.none;
        }
      },
      onDropEnter: (event) {
        setState(() {
          iconColor = Color.fromARGB(40, 0, 0, 0);
        });
      },
      onDropLeave: (event) {
        setState(() {
          iconColor = Color.fromARGB(50, 0, 0, 0);
        });
      },
      onPerformDrop: (event) async {
        final item = event.session.items.first;
        // data reader is available now
        final reader = item.dataReader!;
        final appName = await reader.getSuggestedName();
        if (appName!.endsWith(".app")) {
          reader.getValue(
              Formats.fileUri, (value) => widget.controller.text = value!.path);
        } else {
          // ignore: use_build_context_synchronously
          await displayInfoBar(context, builder: (context, close) {
            return InfoBar(
              title: Text(AppLocalizations.of(context)!.wrongTypeFile),
              action: IconButton(
                icon: const Icon(FluentIcons.clear),
                onPressed: close,
              ),
              severity: InfoBarSeverity.warning,
            );
          });
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                  color: iconColor,
                ),
              )),
          Icon(
            FluentIcons.add_medium,
            size: 60.0,
            color: iconColor,
          ),
        ],
      ),
    );
  }
}
