import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';

class FilePickerBox extends StatelessWidget {
  final TextEditingController controller;
  const FilePickerBox({super.key, required this.controller});

  Future<void> _pickDir() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['app'],
      initialDirectory: "/Applications",
    );
    if (result != null) {
      String pickedPath = result.paths.first ?? "";
      // 去除不需要的前缀部分，假设路径以 '/Volumes/Macintosh HD' 开头
      if (pickedPath.startsWith('/Volumes/Macintosh HD')) {
        pickedPath = pickedPath.replaceFirst('/Volumes/Macintosh HD', '');
      }
      controller.text = pickedPath;
    } else {
      debugPrint("User cancelled the folder picker");
    }
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
