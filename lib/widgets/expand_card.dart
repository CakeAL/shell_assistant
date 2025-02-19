import 'package:fluent_ui/fluent_ui.dart';
import 'package:shell_assistant/src/rust/api/command.dart';

class ExpandCard extends StatelessWidget {
  const ExpandCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
    this.path,
    this.initiallyExpanded = false,
  });

  final IconData icon;
  final String title;
  final Widget content;
  final String? path;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Expander(
      header: Row(
          children: [Icon(icon, size: 20), SizedBox(width: 10), Text(title)]),
      content: content,
      // initiallyExpanded: true,
      trailing: Container(
        height: 31,
        constraints: const BoxConstraints(minWidth: 75),
        child: path == null
            ? null
            : Button(
                child: const Row(children: [
                  Icon(FluentIcons.open_in_new_window),
                  SizedBox(width: 6.0),
                  Text('Open')
                ]),
                onPressed: () => openFolder(path: path!),
              ),
      ),
      initiallyExpanded: initiallyExpanded,
    );
  }
}
