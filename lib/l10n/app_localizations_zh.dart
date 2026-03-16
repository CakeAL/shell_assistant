// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get shellAssistant => '果壳助手';

  @override
  String get bypassSignature => '绕过签名';

  @override
  String get signature => '签名';

  @override
  String get settings => '设置';

  @override
  String get theme => '主题';

  @override
  String get system => '跟随系统';

  @override
  String get light => '亮色';

  @override
  String get dark => '暗色';

  @override
  String get language => '语言';

  @override
  String get submit => '提交';

  @override
  String get cancel => '取消';

  @override
  String get wrongTypeFile => '你应该在这里拖拽一个 App！';

  @override
  String get bypassFunction => '绕过签名可以解决大多数从网络上下载的应用运行时出现“已损坏/不受信任”的问题。';

  @override
  String get bypassUsage => '使用方法：从访达中拖拽应用，或从访达中手动选择，最后点击提交。';

  @override
  String get openToSee => '打开来看指令';

  @override
  String get enterPassword => '输入密码以允许操作';

  @override
  String get systemScreenshot => '系统截图';

  @override
  String get screenshotSavedLocation => '截图保存位置';

  @override
  String get fileNamePrefix => '文件名前缀';

  @override
  String get screenshotFormat => '截图格式';

  @override
  String get disabledScreenshotsShadow => '禁用窗口截图阴影';

  @override
  String get fileNameWithTimestamp => '文件名包含时间戳';

  @override
  String get screenshotThumbnail => '截图后显示缩略图';

  @override
  String get writeSettings => '写入设置';

  @override
  String get resetToDefault => '恢复默认';

  @override
  String get dock => '程序坞';

  @override
  String get openStackByScroll => '用滚轮/滑动打开堆栈';

  @override
  String get openStackByScrollDescription => '这意味着你可以在程序坞通过滚轮/滑动的方式打开一个文件夹。';

  @override
  String get highlightIconHoverOver => '光标滑过堆栈时高亮';

  @override
  String get highlightIconHoverOverDescription => '当你在程序坞上打开一个堆栈，光标滑过的图标会高亮显示。';

  @override
  String get enableSingleAppMode => '启用单应用程序模式';

  @override
  String get enableSingleAppModeDescription => '点击程序坞的应用时，其他窗口都会隐藏。（已弃用）';

  @override
  String get disableAdjustDockSize => '禁用调节程序坞大小';

  @override
  String get disableAdjustDockSizeDescription =>
      '如果你开启这个，你将无法通过鼠标点击并拖动的方式调节程序坞大小。';

  @override
  String get useSuckEffect => '使用吮吸最小化效果';

  @override
  String get useSuckEffectDescription => '启用吮吸作为最小化动画效果。默认的是神奇效果。';

  @override
  String get animationTime => '出现/隐藏动画时长';

  @override
  String get animationTimeDescription =>
      '如果你开启了自动隐藏程序坞，可以通过这个调整弹出的动画时长。\n0 ms 意味着程序坞出现没有任何动画。';

  @override
  String get autohideDelay => '程序坞响应时间';

  @override
  String get autohideDelayDescription =>
      '如果你开启了自动隐藏程序坞，可以通过这个调整鼠标贴靠边缘时程序坞延迟出现的速度。\n0 ms 意味着程序坞将会立刻出现。';

  @override
  String get systemInfo => '系统信息';

  @override
  String get hostName => '主机名';

  @override
  String get userName => '用户名';

  @override
  String get cpuModel => '处理器型号';

  @override
  String get numberOfCpus => '核心';

  @override
  String get kernel => '内核';

  @override
  String get kernelVersion => '内核版本';

  @override
  String get osVersion => '系统版本';

  @override
  String get memory => '内存大小';

  @override
  String get swap => '交换大小';

  @override
  String get diskInfo => '硬盘信息';

  @override
  String get diskName => '硬盘名';

  @override
  String get fileSystem => '文件系统';

  @override
  String get diskType => '硬盘类型';

  @override
  String get mountPoint => '挂载点';

  @override
  String get removable => '是否可移除';

  @override
  String get availableSpace => '可用空间';

  @override
  String get batteryInfo => '电池信息';

  @override
  String get currentCapacity => '当前电池百分比';

  @override
  String get designCapacity => '设计电池容量';

  @override
  String get rawCurrentCapacity => '当前电池电量';

  @override
  String get rawMaxCapacity => '可达到最大电池电量';

  @override
  String get hardwareBatteryPercentage => '硬件电池百分比';

  @override
  String get sipStatus => '是否开启 SIP';

  @override
  String get timeSinceBoot => '已开机时间';

  @override
  String get otherFunctions => '其他功能';

  @override
  String get openDynamicWallpapersFolder => '打开动态壁纸文件夹';

  @override
  String get openWallpapersFolder => '打开壁纸文件夹';

  @override
  String get openRecordingsFolder => '打开录音文件夹';

  @override
  String get currentFolderSize => '当前文件夹大小';

  @override
  String get folderPath => '文件夹路径';

  @override
  String get extractAppIcon => '提取 App 图标';

  @override
  String get extractAppIconDescription =>
      '可以用来提取你选择的 APP 的图标文件到下载文件夹中，并转换为 iconset。（仅适用于 macOS App，iPadOS/iOS App 不能用） ';

  @override
  String get preventAutoBoot => '阻止自动开机';

  @override
  String get preventAutoBootRequirements =>
      '只能用于 macOS 15.0 及以上，且 CPU 应该是 M 系列的。';

  @override
  String get preventAutoBootUsage => '你需要选择你不想自动开机的情况，然后点击下方按钮。';

  @override
  String get openTheLaptopLid => '打开笔记本盖子';

  @override
  String get connectToThePower => '连接电源';

  @override
  String get bootOptions => '启动选项';

  @override
  String get playSoundOnStartup => '开机发出 Duang 的一声';

  @override
  String get newVersionFound => '发现新版本';

  @override
  String get openReleasePage => '打开发布页面';

  @override
  String get getAppArch => '获取 App 架构';

  @override
  String get appArchs => '此应用的架构是';

  @override
  String get universal =>
      '该 App 是一个通用架构的 App，既可以在 Intel 芯片也可以在 Apple Silicon 的 macOS 上运行。';

  @override
  String get onlyArm =>
      '该 App 是一个 arm64 架构的 App，只能在 Apple Silicon 的 macOS 上运行。';

  @override
  String get onlyIntel =>
      '该 App 是一个 x86_64 架构的 App，既可以在 Intel 芯片也可以在 Apple Silicon 的 macOS 上运行（通过Rosetta 2转译）';

  @override
  String get onlyPowerPC => '该 App 是一个 PowerPC 架构的 App，已经不能在现代的 mac 上运行';
}
