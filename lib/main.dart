import 'package:desktop_window/desktop_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:shell_assistant/src/rust/frb_generated.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  await RustLib.init();
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMinWindowSize(Size(800, 600));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: FluentApp(
        title: "Shell Assistant",
        theme: FluentThemeData(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}

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
                    {setState(() => displayMode = PaneDisplayMode.compact)}
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
          ));
    });
  }
}
