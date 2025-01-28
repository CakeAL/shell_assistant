import 'package:desktop_window/desktop_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:provider/provider.dart';
import 'package:shell_assistant/pages/bypass_signature.dart';
import 'package:shell_assistant/pages/settings.dart';
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
  await Window.setEffect(
      effect: WindowEffect.menu);
  // await Window.makeTitlebarTransparent();
  // await Window.enableFullSizeContentView();
  runApp(const MyApp());
}

final _appTheme = AppTheme();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext bugcontext) {
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
  var selectedIndex = 0;
  var displayMode = PaneDisplayMode.open;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = BypassSignature();
      case 2:
        page = Settings();
      default:
        page = Center(
          child: Text('fsdafaf'),
        );
      // throw UnimplementedError("No widget for $selectedIndex");
    }
    return LayoutBuilder(builder: (context, constraints) {
      return NavigationView(
          appBar: NavigationAppBar(
            title: Text(AppLocalizations.of(context)!.shellAssistant),
            automaticallyImplyLeading: false,
          ),
          pane: NavigationPane(
              selected: selectedIndex,
              onItemPressed: (index) => {
                    if (index == selectedIndex)
                      {
                        if (displayMode == PaneDisplayMode.open)
                          {
                            setState(
                                () => displayMode = PaneDisplayMode.compact)
                          }
                        else if (displayMode == PaneDisplayMode.compact)
                          {setState(() => displayMode == PaneDisplayMode.open)}
                      }
                  },
              onChanged: (value) => setState(() => selectedIndex = value),
              size: NavigationPaneSize(openWidth: 200.0),
              displayMode: PaneDisplayMode.open,
              items: [
                PaneItem(
                    icon: const Icon(FluentIcons.rev_toggle_key),
                    title: Text(AppLocalizations.of(context)!.bypassSignature),
                    body: page),
                PaneItem(
                    icon: const Icon(FluentIcons.signin),
                    title: Text(AppLocalizations.of(context)!.signature),
                    body: page)
              ],
              footerItems: [
                PaneItem(
                    icon: const Icon(FluentIcons.settings),
                    title: Text(AppLocalizations.of(context)!.settings),
                    body: page)
              ]));
    });
  }
}
