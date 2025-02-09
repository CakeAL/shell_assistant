import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shell_assistant/src/rust/api/command.dart';
import 'package:shell_assistant/src/rust/api/entity.dart';

class SystemInformation extends StatefulWidget {
  const SystemInformation({super.key});

  @override
  State<SystemInformation> createState() => _SystemInformationState();
}

class _SystemInformationState extends State<SystemInformation> {
  late SystemInfo _systemInfo;
  final _divider = Divider(
      style: DividerThemeData(
          horizontalMargin: EdgeInsets.symmetric(vertical: 10)));
  @override
  void initState() {
    super.initState();
    _systemInfo = getSystemInfo();
  }

  Widget _row(String text1, String text2) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(text1),
        ),
        Expanded(flex: 2, child: SelectableText(text2))
      ],
    );
  }

  Widget _firstCard() {
    return Expander(
      header: Row(children: [
        Icon(FluentIcons.info, size: 20),
        SizedBox(width: 10),
        Text(AppLocalizations.of(context)!.systemInfo)
      ]),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30), // 左侧空出 20
            child: Column(
              children: [
                _row(AppLocalizations.of(context)!.hostName,
                    _systemInfo.hostName ?? "Unknown host name"),
                _row(AppLocalizations.of(context)!.cpuModel,
                    "${_systemInfo.cpuModel} (${_systemInfo.numberOfCpus} ${AppLocalizations.of(context)!.numberOfCpus})"),
                _row(AppLocalizations.of(context)!.memory,
                    "${_systemInfo.totalMemory / BigInt.from(1024 * 1024 * 1024)} GiB"),
                _row(AppLocalizations.of(context)!.swap,
                    "${_systemInfo.totalSwap / BigInt.from(1024 * 1024 * 1024)} GiB")
              ],
            ),
          ),
          _divider,
          Padding(
              padding: const EdgeInsets.only(left: 30), // 左侧空出 20
              child: Column(children: [
                _row(AppLocalizations.of(context)!.userName,
                    _systemInfo.userName ?? "Unknown username"),
                _row(AppLocalizations.of(context)!.osVersion,
                    "macOS ${_systemInfo.osVersion ?? "Unknown"}"),
                _row(AppLocalizations.of(context)!.kernel,
                    _systemInfo.systemName ?? "Unknown kernel"),
                _row(AppLocalizations.of(context)!.kernelVersion,
                    _systemInfo.kernelVersion ?? "Unknown kernel version"),
                _row(AppLocalizations.of(context)!.sipStatus,
                    _systemInfo.sipStatus ?? "Unknown")
              ])),
        ],
      ),
      initiallyExpanded: true,
    );
  }

  Widget _secondCard() {
    return Expander(
      header: Row(children: [
        Icon(FluentIcons.hard_drive, size: 20),
        SizedBox(width: 10),
        Text(AppLocalizations.of(context)!.diskInfo)
      ]),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(_systemInfo.diskInfos.length, (index) {
          return Padding(
              padding: const EdgeInsets.only(left: 30), // 左侧空出 20
              child: Column(
                children: [
                  _row(AppLocalizations.of(context)!.diskName,
                      _systemInfo.diskInfos[index].name),
                  _row(AppLocalizations.of(context)!.fileSystem,
                      _systemInfo.diskInfos[index].fileSystem),
                  _row(AppLocalizations.of(context)!.diskType,
                      _systemInfo.diskInfos[index].diskType),
                  _row(AppLocalizations.of(context)!.mountPoint,
                      _systemInfo.diskInfos[index].mountPoint),
                  _row(AppLocalizations.of(context)!.removable,
                      _systemInfo.diskInfos[index].removable ? "Yes" : "No"),
                  _row(AppLocalizations.of(context)!.availableSpace,
                      "${(_systemInfo.diskInfos[index].availableSpace / BigInt.from(1024 * 1024 * 1024)).toStringAsFixed(2)} / ${(_systemInfo.diskInfos[index].totalSpace / BigInt.from(1024 * 1024 * 1024)).toStringAsFixed(2)} GiB (${(_systemInfo.diskInfos[index].availableSpace / _systemInfo.diskInfos[index].totalSpace * 100.0).toStringAsFixed(2)} %)"),
                  index >= _systemInfo.diskInfos.length - 1
                      ? SizedBox()
                      : _divider,
                ],
              ));
        }),
      ),
    );
  }

  Widget _thirdCard() {
    return Expander(
        header: Row(children: [
          Icon(FluentIcons.database, size: 20),
          SizedBox(width: 10),
          Text(AppLocalizations.of(context)!.batteryInfo)
        ]),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 30), // 左侧空出 20
                child: Column(
                  children: [
                    _row(AppLocalizations.of(context)!.currentCapacity,
                        "${_systemInfo.batteryInfo.currentCapacity} %"),
                    _row(AppLocalizations.of(context)!.rawCurrentCapacity,
                        "${_systemInfo.batteryInfo.appleRawCurrentCapacity} mAh"),
                    _row(
                        AppLocalizations.of(context)!.hardwareBatteryPercentage,
                        "${(_systemInfo.batteryInfo.appleRawCurrentCapacity / _systemInfo.batteryInfo.appleRawMaxCapacity * 100.0).toStringAsFixed(2)} %"),
                    _row(AppLocalizations.of(context)!.designCapacity,
                        "${_systemInfo.batteryInfo.designCapacity} mAh"),
                    _row(AppLocalizations.of(context)!.rawMaxCapacity,
                        "${_systemInfo.batteryInfo.appleRawMaxCapacity} mAh (${(_systemInfo.batteryInfo.appleRawMaxCapacity / _systemInfo.batteryInfo.designCapacity * 100.0).toStringAsFixed(2)} %)"),
                  ],
                ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text(AppLocalizations.of(context)!.systemInfo)),
      children: [
        _firstCard(),
        SizedBox(height: 10),
        _secondCard(),
        SizedBox(height: 10),
        _thirdCard()
      ],
    );
  }
}
