use std::{collections::HashMap, fs, process::Command, sync::LazyLock};

use walkdir::WalkDir;

use crate::api::entity::{DiskInfo, SystemInfo};
use crate::api::util::*;

use super::util::{get_app_icon, iconutil_convert};

#[flutter_rust_bridge::frb(sync)]
pub fn execute_bypass_signature(path: String, password: String) -> Result<String, String> {
    let args = vec![
        "-S".to_string(),
        "xattr".to_string(),
        "-d".to_string(),
        "com.apple.quarantine".to_string(),
        path.clone(),
    ];
    execute_sudo_command(args, password)
}

static SCREENSHOT_SETTINGS: LazyLock<Vec<&str>> = LazyLock::new(|| {
    vec![
        "location",
        "name",
        "type",
        "disable-shadow",
        "include-date",
        "show-thumbnail",
    ]
});

#[flutter_rust_bridge::frb(sync)]
pub fn execute_write_screenshot_settings(command_map: HashMap<i32, String>) {
    // 遍历 commandMap，分步执行
    command_map.iter().for_each(|(&key, value)| {
        let _value = format!("\"{value}\"");
        let args = match key {
            0..=2 => vec![SCREENSHOT_SETTINGS[key as usize], &_value],
            3..=5 => vec![SCREENSHOT_SETTINGS[key as usize], "-bool", value],
            _ => return, // 如果没有匹配项，跳过当前循环
        };

        let _ = Command::new("defaults")
            .args(["write", "com.apple.screencapture"])
            .args(args)
            .output();
    });
    let _ = Command::new("killall").arg("SystemUIServer").output();
}

#[flutter_rust_bridge::frb(sync)]
pub fn execute_reset_screenshot_settings() {
    SCREENSHOT_SETTINGS.iter().for_each(|value| {
        let _ = Command::new("defaults")
            .args(["delete", "com.apple.screencapture", value])
            .output();
    });
    let _ = Command::new("killall").arg("SystemUIServer").output();
}

static DOCK_SETTINGS: LazyLock<Vec<&str>> = LazyLock::new(|| {
    vec![
        "scroll-to-open",
        "mouse-over-hilite-stack",
        "single-app",
        "size-immutable",
        "mineffect",
        "autohide-time-modifier",
        "autohide-delay",
    ]
});

#[flutter_rust_bridge::frb(sync)]
pub fn execute_write_dock_settings(
    switch_states: Vec<bool>,
    animation_time: Option<f64>,
    delay_time: Option<f64>,
) {
    let state = ("true", "false");
    #[allow(unused_assignments)]
    let mut str_time = String::new();
    for (i, setting) in DOCK_SETTINGS.iter().enumerate() {
        let args = match i {
            0..=3 => {
                vec![
                    *setting,
                    "-bool",
                    if switch_states[i] { state.0 } else { state.1 },
                ]
            }
            4 => {
                vec![
                    *setting,
                    "-string",
                    if switch_states[i] { "suck" } else { "genie" },
                ]
            }
            5 | 6 => {
                let time = if i == 5 { animation_time } else { delay_time };
                if let Some(t) = time {
                    str_time = (t / 1000.0).to_string();
                    vec![*setting, "-float", &str_time]
                } else {
                    continue;
                }
            }
            _ => continue, // Skip invalid indices
        };
        let _ = Command::new("defaults")
            .args(["write", "com.apple.dock"])
            .args(args)
            .output();
    }
    let _ = Command::new("killall").arg("Dock").output();
}

#[flutter_rust_bridge::frb(sync)]
pub fn execute_reset_dock_settings() {
    DOCK_SETTINGS.iter().for_each(|value| {
        let _ = Command::new("defaults")
            .args(["delete", "com.apple.dock", value])
            .output();
    });
    let _ = Command::new("killall").arg("Dock").output();
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_user_name() -> Option<String> {
    Command::new("whoami")
        .output()
        .ok()
        .and_then(|output| Some(String::from_utf8_lossy(&output.stdout).trim().to_string()))
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_system_info() -> SystemInfo {
    use sysinfo::{Disks, System};
    let mut sys = System::new_all();
    sys.refresh_all();

    let cpu_model = sys
        .cpus()
        .first()
        .map(|cpu| cpu.brand())
        .unwrap_or("Unknown");

    let disks = Disks::new_with_refreshed_list()
        .iter()
        .map(|disk| DiskInfo {
            name: disk.name().to_string_lossy().to_string(),
            file_system: disk.file_system().to_string_lossy().to_string(),
            disk_type: disk.kind().to_string(),
            mount_point: disk.mount_point().to_string_lossy().to_string(),
            removable: disk.is_removable(),
            total_space: disk.total_space(),
            available_space: disk.available_space(),
        })
        .collect::<Vec<_>>();

    let sip_status = Command::new("csrutil")
        .arg("status")
        .output()
        .ok()
        .and_then(|output| {
            String::from_utf8_lossy(&output.stdout)
                .split(':')
                .last()
                .map(|s| s.trim().to_string())
        });

    SystemInfo {
        host_name: System::host_name(),
        user_name: get_user_name(),
        cpu_model: cpu_model.to_string(),
        number_of_cpus: sys.cpus().len() as i32,
        system_name: System::name(),
        kernel_version: System::kernel_version(),
        os_version: System::os_version(),
        total_memory: sys.total_memory(),
        total_swap: sys.total_swap(),
        sip_status,
        time_since_boot: calculate_time_since_boot().ok(),
        disk_infos: disks,
        battery_info: get_battery_info().unwrap_or_default(),
    }
}

#[flutter_rust_bridge::frb(sync)]
pub fn open_folder(path: String) {
    let _ = Command::new("open").arg(path).status();
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_folder_size(path: String) -> u64 {
    WalkDir::new(path)
        .into_iter()
        .filter_map(|entry| entry.ok()) // 过滤掉错误的文件
        .filter_map(|entry| fs::metadata(entry.path()).ok()) // 获取元数据
        .map(|metadata| metadata.len()) // 获取文件大小
        .sum()
}

#[flutter_rust_bridge::frb(sync)]
pub fn get_icon_and_convert(path: String) -> Result<String, String> {
    let icon_path = get_app_icon(&path).map_err(|e| e.to_string())?;
    iconutil_convert(&icon_path).map_err(|e| e.to_string())?;
    icon_path
        .to_str()
        .map(String::from)
        .ok_or_else(|| "No such icon path".to_string())
}

// function 0: sudo nvram BootPreference=%00
// function 1: sudo nvram StartupMute=%00
#[flutter_rust_bridge::frb(sync)]
pub fn set_nvram(function: u8, value: Option<u8>, password: String) -> Result<String, String> {
    let mut args = vec!["-S".to_string(), "nvram".to_string()];
    let function = match function {
        0 => "BootPreference",
        1 => "StartupMute",
        _ => return Err("Invalid function".to_string()),
    };
    match value {
        Some(v) => {
            let preference = format!("{function}=%{:02x}", v);
            args.push(preference);
        }
        None => {
            args.extend(vec!["-d".to_string(), function.to_string()]);
        }
    }

    execute_sudo_command(args, password)
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_execute_bypass_signature() {
        let result = execute_bypass_signature("/Applications/Arc.app".to_string(), "".to_string());
        dbg!(result.unwrap());
    }

    #[test]
    fn test_execute_write_screenshot_settings() {
        let command_map = HashMap::from([
            (0, "/Users/cakeal/Pictures".to_string()),
            (1, "123".to_string()),
            (2, "bmp".to_string()),
            (3, "true".to_string()),
            (4, "false".to_string()),
            (5, "false".to_string()),
        ]);
        execute_write_screenshot_settings(command_map);
    }

    #[test]
    fn test_get_system_info() {
        get_system_info();
    }

    #[test]
    fn test_open_folder() {
        let path = "/Library/Application Support/com.apple.idleassetsd/Customer".to_string();
        open_folder(path.clone());
        dbg!(get_folder_size(path));
    }

    #[test]
    fn test_set_boot_preference() {
        let res = set_nvram(0, None, "000000".to_string());
        dbg!(res.unwrap());
    }

    #[test]
    fn test_set_startup_mute() {
        let res = set_nvram(1, Some(0), "000000".to_string());
        dbg!(res.unwrap());
    }
}
