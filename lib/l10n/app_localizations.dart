import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @shellAssistant.
  ///
  /// In en, this message translates to:
  /// **'Shell Assistant'**
  String get shellAssistant;

  /// No description provided for @bypassSignature.
  ///
  /// In en, this message translates to:
  /// **'Bypass Signature'**
  String get bypassSignature;

  /// No description provided for @signature.
  ///
  /// In en, this message translates to:
  /// **'Signature'**
  String get signature;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @wrongTypeFile.
  ///
  /// In en, this message translates to:
  /// **'You should drop a app!'**
  String get wrongTypeFile;

  /// No description provided for @bypassFunction.
  ///
  /// In en, this message translates to:
  /// **'Bypass Signature can solve the issue of applications being marked as \'damaged\' or \'untrusted\' after being downloaded from the internet. '**
  String get bypassFunction;

  /// No description provided for @bypassUsage.
  ///
  /// In en, this message translates to:
  /// **'How to use: Drag and drop the application from Finder, or select it manually from Finder, then press the \"Submit\". '**
  String get bypassUsage;

  /// No description provided for @openToSee.
  ///
  /// In en, this message translates to:
  /// **'Open to see the Command'**
  String get openToSee;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password to allow the operation'**
  String get enterPassword;

  /// No description provided for @systemScreenshot.
  ///
  /// In en, this message translates to:
  /// **'System Screenshot'**
  String get systemScreenshot;

  /// No description provided for @screenshotSavedLocation.
  ///
  /// In en, this message translates to:
  /// **'Screenshot saved location'**
  String get screenshotSavedLocation;

  /// No description provided for @fileNamePrefix.
  ///
  /// In en, this message translates to:
  /// **'File name prefix'**
  String get fileNamePrefix;

  /// No description provided for @screenshotFormat.
  ///
  /// In en, this message translates to:
  /// **'Screenshot format'**
  String get screenshotFormat;

  /// No description provided for @disabledScreenshotsShadow.
  ///
  /// In en, this message translates to:
  /// **'Disabled windowed screenshots shadow'**
  String get disabledScreenshotsShadow;

  /// No description provided for @fileNameWithTimestamp.
  ///
  /// In en, this message translates to:
  /// **'File name with timestamp'**
  String get fileNameWithTimestamp;

  /// No description provided for @screenshotThumbnail.
  ///
  /// In en, this message translates to:
  /// **'Show Floating thumbnails'**
  String get screenshotThumbnail;

  /// No description provided for @writeSettings.
  ///
  /// In en, this message translates to:
  /// **'Write settings'**
  String get writeSettings;

  /// No description provided for @resetToDefault.
  ///
  /// In en, this message translates to:
  /// **'Reset to default'**
  String get resetToDefault;

  /// No description provided for @dock.
  ///
  /// In en, this message translates to:
  /// **'Dock'**
  String get dock;

  /// No description provided for @openStackByScroll.
  ///
  /// In en, this message translates to:
  /// **'Open stack by scroll'**
  String get openStackByScroll;

  /// No description provided for @openStackByScrollDescription.
  ///
  /// In en, this message translates to:
  /// **'It means that you can open a stack of the folder icon on dock through scrolling. '**
  String get openStackByScrollDescription;

  /// No description provided for @highlightIconHoverOver.
  ///
  /// In en, this message translates to:
  /// **'Highlight the icon in stack when cursor hovering'**
  String get highlightIconHoverOver;

  /// No description provided for @highlightIconHoverOverDescription.
  ///
  /// In en, this message translates to:
  /// **'When you open stack of a folder, you can highlight the icon where your cursor is hovering. '**
  String get highlightIconHoverOverDescription;

  /// No description provided for @enableSingleAppMode.
  ///
  /// In en, this message translates to:
  /// **'Enable single-app mode'**
  String get enableSingleAppMode;

  /// No description provided for @enableSingleAppModeDescription.
  ///
  /// In en, this message translates to:
  /// **'When you click a app on dock, the others would be hidden. (Deprecated)'**
  String get enableSingleAppModeDescription;

  /// No description provided for @disableAdjustDockSize.
  ///
  /// In en, this message translates to:
  /// **'Disable adjust the size of dock'**
  String get disableAdjustDockSize;

  /// No description provided for @disableAdjustDockSizeDescription.
  ///
  /// In en, this message translates to:
  /// **'If you enable it, you won\'t adjust the size of dock by mouse clicking and sliding. '**
  String get disableAdjustDockSizeDescription;

  /// No description provided for @useSuckEffect.
  ///
  /// In en, this message translates to:
  /// **'Use the Suck effect to minimize'**
  String get useSuckEffect;

  /// No description provided for @useSuckEffectDescription.
  ///
  /// In en, this message translates to:
  /// **'Enable the Suck Animation for minimizing. The default effect is Genie.'**
  String get useSuckEffectDescription;

  /// No description provided for @animationTime.
  ///
  /// In en, this message translates to:
  /// **'The time of animation to appear or hide'**
  String get animationTime;

  /// No description provided for @animationTimeDescription.
  ///
  /// In en, this message translates to:
  /// **'If you enable auto hide, you can adjust the time of the animation when dock appears. \n0 ms means no animation. '**
  String get animationTimeDescription;

  /// No description provided for @autohideDelay.
  ///
  /// In en, this message translates to:
  /// **'Dock auto hide delay'**
  String get autohideDelay;

  /// No description provided for @autohideDelayDescription.
  ///
  /// In en, this message translates to:
  /// **'If you enable auto hide, you can adjust the delay time of the dock appearance when the cursor touchs the screen edges. \n0 ms means that dock will appear immediately'**
  String get autohideDelayDescription;

  /// No description provided for @systemInfo.
  ///
  /// In en, this message translates to:
  /// **'System information'**
  String get systemInfo;

  /// No description provided for @hostName.
  ///
  /// In en, this message translates to:
  /// **'Host name'**
  String get hostName;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get userName;

  /// No description provided for @cpuModel.
  ///
  /// In en, this message translates to:
  /// **'CPU model'**
  String get cpuModel;

  /// No description provided for @numberOfCpus.
  ///
  /// In en, this message translates to:
  /// **'Cores'**
  String get numberOfCpus;

  /// No description provided for @kernel.
  ///
  /// In en, this message translates to:
  /// **'Kernel'**
  String get kernel;

  /// No description provided for @kernelVersion.
  ///
  /// In en, this message translates to:
  /// **'Kernel version'**
  String get kernelVersion;

  /// No description provided for @osVersion.
  ///
  /// In en, this message translates to:
  /// **'OS version'**
  String get osVersion;

  /// No description provided for @memory.
  ///
  /// In en, this message translates to:
  /// **'Memory'**
  String get memory;

  /// No description provided for @swap.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get swap;

  /// No description provided for @diskInfo.
  ///
  /// In en, this message translates to:
  /// **'Disk information'**
  String get diskInfo;

  /// No description provided for @diskName.
  ///
  /// In en, this message translates to:
  /// **'Disk name'**
  String get diskName;

  /// No description provided for @fileSystem.
  ///
  /// In en, this message translates to:
  /// **'File system'**
  String get fileSystem;

  /// No description provided for @diskType.
  ///
  /// In en, this message translates to:
  /// **'Disk type'**
  String get diskType;

  /// No description provided for @mountPoint.
  ///
  /// In en, this message translates to:
  /// **'Mount point'**
  String get mountPoint;

  /// No description provided for @removable.
  ///
  /// In en, this message translates to:
  /// **'Removable'**
  String get removable;

  /// No description provided for @availableSpace.
  ///
  /// In en, this message translates to:
  /// **'Available space'**
  String get availableSpace;

  /// No description provided for @batteryInfo.
  ///
  /// In en, this message translates to:
  /// **'Battery information'**
  String get batteryInfo;

  /// No description provided for @currentCapacity.
  ///
  /// In en, this message translates to:
  /// **'Current battery percentage'**
  String get currentCapacity;

  /// No description provided for @designCapacity.
  ///
  /// In en, this message translates to:
  /// **'Design capacity'**
  String get designCapacity;

  /// No description provided for @rawCurrentCapacity.
  ///
  /// In en, this message translates to:
  /// **'Raw current capacity'**
  String get rawCurrentCapacity;

  /// No description provided for @rawMaxCapacity.
  ///
  /// In en, this message translates to:
  /// **'Raw max capacity'**
  String get rawMaxCapacity;

  /// No description provided for @hardwareBatteryPercentage.
  ///
  /// In en, this message translates to:
  /// **'Hardware battery percentage'**
  String get hardwareBatteryPercentage;

  /// No description provided for @sipStatus.
  ///
  /// In en, this message translates to:
  /// **'SIP status'**
  String get sipStatus;

  /// No description provided for @timeSinceBoot.
  ///
  /// In en, this message translates to:
  /// **'Time since boot'**
  String get timeSinceBoot;

  /// No description provided for @otherFunctions.
  ///
  /// In en, this message translates to:
  /// **'Other functions'**
  String get otherFunctions;

  /// No description provided for @openDynamicWallpapersFolder.
  ///
  /// In en, this message translates to:
  /// **'Open dynamic wallpapers folder'**
  String get openDynamicWallpapersFolder;

  /// No description provided for @openWallpapersFolder.
  ///
  /// In en, this message translates to:
  /// **'Open wallpapers folder'**
  String get openWallpapersFolder;

  /// No description provided for @openRecordingsFolder.
  ///
  /// In en, this message translates to:
  /// **'Open recordings folder'**
  String get openRecordingsFolder;

  /// No description provided for @currentFolderSize.
  ///
  /// In en, this message translates to:
  /// **'Current folder size'**
  String get currentFolderSize;

  /// No description provided for @folderPath.
  ///
  /// In en, this message translates to:
  /// **'Folder path'**
  String get folderPath;

  /// No description provided for @extractAppIcon.
  ///
  /// In en, this message translates to:
  /// **'Extract App icon'**
  String get extractAppIcon;

  /// No description provided for @extractAppIconDescription.
  ///
  /// In en, this message translates to:
  /// **'It can move the icon you selected into download folder, and convert it to iconset. (Only for macOS Apps, not iPadOS/iOS App) '**
  String get extractAppIconDescription;

  /// No description provided for @preventAutoBoot.
  ///
  /// In en, this message translates to:
  /// **'Prevent auto boot'**
  String get preventAutoBoot;

  /// No description provided for @preventAutoBootRequirements.
  ///
  /// In en, this message translates to:
  /// **'Only for macOS 15.0 and above, and CPU should be M series. '**
  String get preventAutoBootRequirements;

  /// No description provided for @preventAutoBootUsage.
  ///
  /// In en, this message translates to:
  /// **'You should select the cases you don\'t want to auto boot, and press the button below. '**
  String get preventAutoBootUsage;

  /// No description provided for @openTheLaptopLid.
  ///
  /// In en, this message translates to:
  /// **'Open the Laptop Lid'**
  String get openTheLaptopLid;

  /// No description provided for @connectToThePower.
  ///
  /// In en, this message translates to:
  /// **'Connect to the power'**
  String get connectToThePower;

  /// No description provided for @bootOptions.
  ///
  /// In en, this message translates to:
  /// **'Boot options'**
  String get bootOptions;

  /// No description provided for @playSoundOnStartup.
  ///
  /// In en, this message translates to:
  /// **'Play sound on startup'**
  String get playSoundOnStartup;

  /// No description provided for @newVersionFound.
  ///
  /// In en, this message translates to:
  /// **'New version found'**
  String get newVersionFound;

  /// No description provided for @openReleasePage.
  ///
  /// In en, this message translates to:
  /// **'Open release page'**
  String get openReleasePage;

  /// No description provided for @getAppArch.
  ///
  /// In en, this message translates to:
  /// **'Get App architecture'**
  String get getAppArch;

  /// No description provided for @appArchs.
  ///
  /// In en, this message translates to:
  /// **'This App\'s architecture is'**
  String get appArchs;

  /// No description provided for @universal.
  ///
  /// In en, this message translates to:
  /// **'This app is a universal app and can run on both Intel Chip and Apple Silicon macOS.'**
  String get universal;

  /// No description provided for @onlyArm.
  ///
  /// In en, this message translates to:
  /// **'This app is an arm64 app and can only run on Apple Silicon macOS.'**
  String get onlyArm;

  /// No description provided for @onlyIntel.
  ///
  /// In en, this message translates to:
  /// **'This app is a x86_64 app and can run on both Intel Chip and Apple Silicon macOS (via Rosetta 2).'**
  String get onlyIntel;

  /// No description provided for @onlyPowerPC.
  ///
  /// In en, this message translates to:
  /// **'This app is a PowerPC app and can\'t run nowadays anymore.'**
  String get onlyPowerPC;

  /// No description provided for @accentColor.
  ///
  /// In en, this message translates to:
  /// **'Accent Color'**
  String get accentColor;

  /// No description provided for @accentColorInfo.
  ///
  /// In en, this message translates to:
  /// **'Need to logout or restart to take effect. '**
  String get accentColorInfo;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
