import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_theme/system_theme.dart';

class AppTheme extends ChangeNotifier {
  AppTheme() {
    _color = SystemTheme.accentColor.accent.toAccentColor();
    SystemTheme.onChange.listen((event) {
      _color = SystemTheme.accentColor.accent.toAccentColor();
    });
    _loadSavedSetting();
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
    _updateMode(mode);
  }

  Locale _locale = PlatformDispatcher.instance.locales.first;
  Locale get locale => _locale;
  set locale(Locale locale) {
    _updateLocale(locale);
  }

  Future<void> _updateMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("mode", mode.name);
    _mode = mode;
    notifyListeners();
  }

  Future<void> _updateLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("locale", locale.languageCode);
    _locale = locale;
    notifyListeners();
  }

  Future<void> _loadSavedSetting() async {
    final prefs = await SharedPreferences.getInstance();
    final modeName = prefs.getString("mode") ?? "system";
    final mode = ThemeMode.values.firstWhere((m) => m.name == modeName);
    _mode = mode;

    final localeCode = prefs.getString("locale") ?? "en";
    final locale = Locale(localeCode);
    _locale = locale;
    notifyListeners();
  }
}
