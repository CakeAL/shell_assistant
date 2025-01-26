import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';

class AppTheme extends ChangeNotifier {
  AppTheme() {
    _color = SystemTheme.accentColor.accent.toAccentColor();
    SystemTheme.onChange.listen((event) {
      _color = SystemTheme.accentColor.accent.toAccentColor();
    });
  }

  AccentColor? _color;
  AccentColor get color => _color ?? Colors.blue;
  set color(AccentColor color) {
    _color = color;
    notifyListeners();
  }

  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;
  set mode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  Locale? _locale = PlatformDispatcher.instance.locales.first;
  Locale? get locale => _locale;
  set locale(Locale? locale) {
    _locale = locale;
    notifyListeners();
  }
}
