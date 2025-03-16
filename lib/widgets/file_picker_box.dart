import 'package:fluent_ui/fluent_ui.dart';
import 'package:file_selector/file_selector.dart';

class FilePickerBox extends StatelessWidget {
  final TextEditingController controller;
  const FilePickerBox({super.key, required this.controller});

  Future<void> _pickDir() async {
    const XTypeGroup typeGroup = XTypeGroup(
        label: 'application',
        uniformTypeIdentifiers: <String>["com.apple.application-bundle"]);
    final XFile? appPath = await openFile(
      acceptedTypeGroups: <XTypeGroup>[typeGroup],
      initialDirectory: "/Applications",
      confirmButtonText: "Select an App",
    );
    controller.text = appPath?.path ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: TextBox(
          placeholder: '/Applications/App Store.app',
          controller: controller,
          onTap: () => _pickDir(),
          readOnly: true,
        ));
  }
}
