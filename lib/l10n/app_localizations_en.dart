// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get shellAssistant => 'Shell Assistant';

  @override
  String get bypassSignature => 'Bypass Signature';

  @override
  String get signature => 'Signature';

  @override
  String get settings => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get submit => 'Submit';

  @override
  String get cancel => 'Cancel';

  @override
  String get wrongTypeFile => 'You should drop a app!';

  @override
  String get bypassFunction =>
      'Bypass Signature can solve the issue of applications being marked as \'damaged\' or \'untrusted\' after being downloaded from the internet. ';

  @override
  String get bypassUsage =>
      'How to use: Drag and drop the application from Finder, or select it manually from Finder, then press the \"Submit\". ';

  @override
  String get openToSee => 'Open to see the Command';

  @override
  String get enterPassword => 'Enter Password to allow the operation';

  @override
  String get systemScreenshot => 'System Screenshot';

  @override
  String get screenshotSavedLocation => 'Screenshot saved location';

  @override
  String get fileNamePrefix => 'File name prefix';

  @override
  String get screenshotFormat => 'Screenshot format';

  @override
  String get disabledScreenshotsShadow =>
      'Disabled windowed screenshots shadow';

  @override
  String get fileNameWithTimestamp => 'File name with timestamp';

  @override
  String get screenshotThumbnail => 'Show Floating thumbnails';

  @override
  String get writeSettings => 'Write settings';

  @override
  String get resetToDefault => 'Reset to default';

  @override
  String get dock => 'Dock';

  @override
  String get openStackByScroll => 'Open stack by scroll';

  @override
  String get openStackByScrollDescription =>
      'It means that you can open a stack of the folder icon on dock through scrolling. ';

  @override
  String get highlightIconHoverOver =>
      'Highlight the icon in stack when cursor hovering';

  @override
  String get highlightIconHoverOverDescription =>
      'When you open stack of a folder, you can highlight the icon where your cursor is hovering. ';

  @override
  String get enableSingleAppMode => 'Enable single-app mode';

  @override
  String get enableSingleAppModeDescription =>
      'When you click a app on dock, the others would be hidden. (Deprecated)';

  @override
  String get disableAdjustDockSize => 'Disable adjust the size of dock';

  @override
  String get disableAdjustDockSizeDescription =>
      'If you enable it, you won\'t adjust the size of dock by mouse clicking and sliding. ';

  @override
  String get useSuckEffect => 'Use the Suck effect to minimize';

  @override
  String get useSuckEffectDescription =>
      'Enable the Suck Animation for minimizing. The default effect is Genie.';

  @override
  String get animationTime => 'The time of animation to appear or hide';

  @override
  String get animationTimeDescription =>
      'If you enable auto hide, you can adjust the time of the animation when dock appears. \n0 ms means no animation. ';

  @override
  String get autohideDelay => 'Dock auto hide delay';

  @override
  String get autohideDelayDescription =>
      'If you enable auto hide, you can adjust the delay time of the dock appearance when the cursor touchs the screen edges. \n0 ms means that dock will appear immediately';

  @override
  String get systemInfo => 'System information';

  @override
  String get hostName => 'Host name';

  @override
  String get userName => 'User name';

  @override
  String get cpuModel => 'CPU model';

  @override
  String get numberOfCpus => 'Cores';

  @override
  String get kernel => 'Kernel';

  @override
  String get kernelVersion => 'Kernel version';

  @override
  String get osVersion => 'OS version';

  @override
  String get memory => 'Memory';

  @override
  String get swap => 'Swap';

  @override
  String get diskInfo => 'Disk information';

  @override
  String get diskName => 'Disk name';

  @override
  String get fileSystem => 'File system';

  @override
  String get diskType => 'Disk type';

  @override
  String get mountPoint => 'Mount point';

  @override
  String get removable => 'Removable';

  @override
  String get availableSpace => 'Available space';

  @override
  String get batteryInfo => 'Battery information';

  @override
  String get currentCapacity => 'Current battery percentage';

  @override
  String get designCapacity => 'Design capacity';

  @override
  String get rawCurrentCapacity => 'Raw current capacity';

  @override
  String get rawMaxCapacity => 'Raw max capacity';

  @override
  String get hardwareBatteryPercentage => 'Hardware battery percentage';

  @override
  String get sipStatus => 'SIP status';

  @override
  String get timeSinceBoot => 'Time since boot';

  @override
  String get otherFunctions => 'Other functions';

  @override
  String get openDynamicWallpapersFolder => 'Open dynamic wallpapers folder';

  @override
  String get openWallpapersFolder => 'Open wallpapers folder';

  @override
  String get openRecordingsFolder => 'Open recordings folder';

  @override
  String get currentFolderSize => 'Current folder size';

  @override
  String get folderPath => 'Folder path';

  @override
  String get extractAppIcon => 'Extract App icon';

  @override
  String get extractAppIconDescription =>
      'It can move the icon you selected into download folder, and convert it to iconset. (Only for macOS Apps, not iPadOS/iOS App) ';

  @override
  String get preventAutoBoot => 'Prevent auto boot';

  @override
  String get preventAutoBootRequirements =>
      'Only for macOS 15.0 and above, and CPU should be M series. ';

  @override
  String get preventAutoBootUsage =>
      'You should select the cases you don\'t want to auto boot, and press the button below. ';

  @override
  String get openTheLaptopLid => 'Open the Laptop Lid';

  @override
  String get connectToThePower => 'Connect to the power';

  @override
  String get bootOptions => 'Boot options';

  @override
  String get playSoundOnStartup => 'Play sound on startup';

  @override
  String get newVersionFound => 'New version found';

  @override
  String get openReleasePage => 'Open release page';

  @override
  String get getAppArch => 'Get App architecture';

  @override
  String get appArchs => 'This App\'s architecture is';

  @override
  String get universal =>
      'This app is a universal app and can run on both Intel Chip and Apple Silicon macOS.';

  @override
  String get onlyArm =>
      'This app is an arm64 app and can only run on Apple Silicon macOS.';

  @override
  String get onlyIntel =>
      'This app is a x86_64 app and can run on both Intel Chip and Apple Silicon macOS (via Rosetta 2).';

  @override
  String get onlyPowerPC =>
      'This app is a PowerPC app and can\'t run nowadays anymore.';

  @override
  String get accentColor => 'Accent Color';

  @override
  String get accentColorInfo => 'Need to logout or restart to take effect. ';

  @override
  String get showsCursor => 'Shows cursor';

  @override
  String get captureHDR => 'Capture HDR (Should use heic format)';
}
