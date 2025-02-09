import 'package:desktop_window/desktop_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:provider/provider.dart';
import 'package:shell_assistant/pages/bypass_signature.dart';
import 'package:shell_assistant/pages/dock.dart';
import 'package:shell_assistant/pages/other_functions.dart';
import 'package:shell_assistant/pages/settings.dart';
import 'package:shell_assistant/pages/system_information.dart';
import 'package:shell_assistant/pages/system_screenshot.dart';
import 'package:shell_assistant/src/rust/api/command.dart';
import 'package:shell_assistant/src/rust/frb_generated.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shell_assistant/theme.dart';
import 'package:system_theme/system_theme.dart';

Future<void> main() async {
  await RustLib.init();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemTheme.accentColor.load();
  await Window.initialize();

  await DesktopWindow.setMinWindowSize(Size(800, 600));
  await Window.setEffect(effect: WindowEffect.menu);
  await Window.makeTitlebarTransparent();
  await Window.enableFullSizeContentView();
  // await Window.hideTitle();
  runApp(const MyApp());
}

final _appTheme = AppTheme();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: _appTheme,
        builder: (context, child) {
          final appTheme = context.watch<AppTheme>();
          return FluentApp(
            title: "Shell Assistant",
            color: appTheme.color,
            theme: FluentThemeData(
              accentColor: appTheme.color,
            ),
            darkTheme: FluentThemeData(
              brightness: Brightness.dark,
              accentColor: appTheme.color,
            ),
            themeMode: appTheme.mode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: appTheme.locale,
            home: MyHomePage(),
            builder: (context, child) {
              return Directionality(
                  textDirection: TextDirection.ltr,
                  child: NavigationPaneTheme(
                      data: NavigationPaneThemeData(
                          backgroundColor: Colors.transparent),
                      child: child!));
            },
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;
  late String? _userName;

  @override
  void initState() {
    super.initState();
    _userName = getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return NavigationView(
          appBar: NavigationAppBar(
            title: Row(
              children: [
                // SizedBox(width: 60),
                // Text(AppLocalizations.of(context)!.shellAssistant),
                Spacer(), // 自动填充剩余空间，把右侧文本推到最右边
                Text('Welcome, $_userName'),
              ],
            ),
            automaticallyImplyLeading: false,
          ),
          pane: NavigationPane(
              selected: _selectedIndex,
              onChanged: (value) => setState(() => _selectedIndex = value),
              size: NavigationPaneSize(openWidth: 200.0),
              displayMode: PaneDisplayMode.open,
              items: [
                PaneItem(
                    icon: const Icon(FluentIcons.rev_toggle_key),
                    title: Text(AppLocalizations.of(context)!.bypassSignature),
                    body: BypassSignature()),
                // PaneItem(
                //     icon: const Icon(FluentIcons.signin),
                //     title: Text(AppLocalizations.of(context)!.signature),
                //     body: Text("No page")),
                PaneItem(
                    icon: const Icon(FluentIcons.desktop_screenshot),
                    title: Text(AppLocalizations.of(context)!.systemScreenshot),
                    body: SystemScreenshot()),
                PaneItem(
                    icon: const Icon(FluentIcons.rectangle_shape),
                    title: Text(AppLocalizations.of(context)!.dock),
                    body: Dock()),
                PaneItem(
                    icon: const Icon(FluentIcons.context_menu),
                    title: Text(AppLocalizations.of(context)!.otherFunctions),
                    body: OtherFunctions()),
              ],
              footerItems: [
                PaneItem(
                    icon: const Icon(FluentIcons.system),
                    title: Text(AppLocalizations.of(context)!.systemInfo),
                    body: SystemInformation()),
                PaneItem(
                    icon: const Icon(FluentIcons.settings),
                    title: Text(AppLocalizations.of(context)!.settings),
                    body: Settings())
              ]));
    });
  }
}
